<?php
declare(strict_types=1);

// GuildWars2 SDK

require_once __DIR__ . '/utility/struct/Struct.php';
require_once __DIR__ . '/core/UtilityType.php';
require_once __DIR__ . '/core/Spec.php';
require_once __DIR__ . '/core/Helpers.php';

// Load utility registration
require_once __DIR__ . '/utility/Register.php';

// Load config and features
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/features.php';

use Voxgig\Struct\Struct;

class GuildWars2SDK
{
    public string $mode;
    public array $features;
    public ?array $options;

    private $_utility;
    private $_rootctx;

    public function __construct(array $options = [])
    {
        $this->mode = "live";
        $this->features = [];
        $this->options = null;

        $utility = new GuildWars2Utility();
        $this->_utility = $utility;

        $config = GuildWars2Config::make_config();

        $this->_rootctx = ($utility->make_context)([
            "client" => $this,
            "utility" => $utility,
            "config" => $config,
            "options" => $options ?? [],
            "shared" => [],
        ], null);

        $this->options = ($utility->make_options)($this->_rootctx);

        if (Struct::getpath($this->options, "feature.test.active") === true) {
            $this->mode = "test";
        }

        $this->_rootctx->options = $this->options;

        // Add features from config.
        $feature_opts = GuildWars2Helpers::to_map(Struct::getprop($this->options, "feature"));
        if ($feature_opts) {
            $items = Struct::items($feature_opts);
            if ($items) {
                foreach ($items as $item) {
                    $fname = $item[0];
                    $fopts = GuildWars2Helpers::to_map($item[1]);
                    if ($fopts && isset($fopts["active"]) && $fopts["active"] === true) {
                        ($utility->feature_add)($this->_rootctx, GuildWars2Features::make_feature($fname));
                    }
                }
            }
        }

        // Add extension features.
        $extend_val = Struct::getprop($this->options, "extend");
        if (is_array($extend_val)) {
            foreach ($extend_val as $f) {
                if (is_object($f) && method_exists($f, 'get_name')) {
                    ($utility->feature_add)($this->_rootctx, $f);
                }
            }
        }

        // Initialize features.
        foreach ($this->features as $f) {
            ($utility->feature_init)($this->_rootctx, $f);
        }

        ($utility->feature_hook)($this->_rootctx, "PostConstruct");
    }

    public function options_map(): array
    {
        $out = Struct::clone($this->options);
        return is_array($out) ? $out : [];
    }

    public function get_utility()
    {
        return GuildWars2Utility::copy($this->_utility);
    }

    public function get_root_ctx()
    {
        return $this->_rootctx;
    }

    public function prepare(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;
        $fetchargs = $fetchargs ?? [];

        $ctrl = GuildWars2Helpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "prepare",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $opts = $this->options;
        $path = Struct::getprop($fetchargs, "path") ?? "";
        $path = is_string($path) ? $path : "";
        $method_val = Struct::getprop($fetchargs, "method") ?? "GET";
        $method_val = is_string($method_val) ? $method_val : "GET";
        $params = GuildWars2Helpers::to_map(Struct::getprop($fetchargs, "params")) ?? [];
        $query = GuildWars2Helpers::to_map(Struct::getprop($fetchargs, "query")) ?? [];
        $headers = ($utility->prepare_headers)($ctx);

        $base = Struct::getprop($opts, "base") ?? "";
        $base = is_string($base) ? $base : "";
        $prefix = Struct::getprop($opts, "prefix") ?? "";
        $prefix = is_string($prefix) ? $prefix : "";
        $suffix = Struct::getprop($opts, "suffix") ?? "";
        $suffix = is_string($suffix) ? $suffix : "";

        $ctx->spec = new GuildWars2Spec([
            "base" => $base, "prefix" => $prefix, "suffix" => $suffix,
            "path" => $path, "method" => $method_val,
            "params" => $params, "query" => $query, "headers" => $headers,
            "body" => Struct::getprop($fetchargs, "body"),
            "step" => "start",
        ]);

        // Merge user-provided headers.
        $uh = Struct::getprop($fetchargs, "headers");
        if (is_array($uh)) {
            foreach ($uh as $k => $v) {
                $ctx->spec->headers[$k] = $v;
            }
        }

        [$_, $err] = ($utility->prepare_auth)($ctx);
        if ($err) {
            return ($utility->make_error)($ctx, $err);
        }

        [$fetchdef, $fd_err] = ($utility->make_fetch_def)($ctx);
        if ($fd_err) {
            return ($utility->make_error)($ctx, $fd_err);
        }
        return $fetchdef;
    }

    public function direct(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;

        // direct() is the raw-HTTP escape hatch: it never throws, it returns
        // an {ok, err, ...} dict. prepare() now raises on error, so catch it
        // and surface the failure through the dict instead.
        try {
            $fetchdef = $this->prepare($fetchargs);
        } catch (\Throwable $err) {
            return ["ok" => false, "err" => $err];
        }

        $fetchargs = $fetchargs ?? [];
        $ctrl = GuildWars2Helpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "direct",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $url = $fetchdef["url"] ?? "";
        [$fetched, $fetch_err] = ($utility->fetcher)($ctx, $url, $fetchdef);

        if ($fetch_err) {
            return ["ok" => false, "err" => $fetch_err];
        }

        if ($fetched === null) {
            return [
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ];
        }

        if (is_array($fetched)) {
            $status = GuildWars2Helpers::to_int(Struct::getprop($fetched, "status"));
            $headers = Struct::getprop($fetched, "headers") ?? [];

            // No-body responses (204, 304) and explicit zero content-length
            // must skip JSON parsing — calling json() on an empty body errors.
            $content_length = is_array($headers) ? ($headers["content-length"] ?? null) : null;
            $no_body = $status === 204 || $status === 304 || (string)$content_length === "0";

            $json_data = null;
            if (!$no_body) {
                $jf = Struct::getprop($fetched, "json");
                if (is_callable($jf)) {
                    try {
                        $json_data = $jf();
                    } catch (\Throwable $e) {
                        // Non-JSON body — leave data null but keep status/ok.
                        $json_data = null;
                    }
                }
            }

            return [
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ];
        }

        return [
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ];
    }


    private $_achievement = null;

    // Canonical facade: $client->Achievement()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->achievement()
    // resolves here too.
    public function Achievement($data = null)
    {
        require_once __DIR__ . '/entity/achievement_entity.php';
        if ($data === null) {
            if ($this->_achievement === null) {
                $this->_achievement = new AchievementEntity($this, null);
            }
            return $this->_achievement;
        }
        return new AchievementEntity($this, $data);
    }


    private $_authenticated = null;

    // Canonical facade: $client->Authenticated()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->authenticated()
    // resolves here too.
    public function Authenticated($data = null)
    {
        require_once __DIR__ . '/entity/authenticated_entity.php';
        if ($data === null) {
            if ($this->_authenticated === null) {
                $this->_authenticated = new AuthenticatedEntity($this, null);
            }
            return $this->_authenticated;
        }
        return new AuthenticatedEntity($this, $data);
    }


    private $_daily_reward = null;

    // Canonical facade: $client->DailyReward()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->daily_reward()
    // resolves here too.
    public function DailyReward($data = null)
    {
        require_once __DIR__ . '/entity/daily_reward_entity.php';
        if ($data === null) {
            if ($this->_daily_reward === null) {
                $this->_daily_reward = new DailyRewardEntity($this, null);
            }
            return $this->_daily_reward;
        }
        return new DailyRewardEntity($this, $data);
    }


    private $_game_mechanic = null;

    // Canonical facade: $client->GameMechanic()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->game_mechanic()
    // resolves here too.
    public function GameMechanic($data = null)
    {
        require_once __DIR__ . '/entity/game_mechanic_entity.php';
        if ($data === null) {
            if ($this->_game_mechanic === null) {
                $this->_game_mechanic = new GameMechanicEntity($this, null);
            }
            return $this->_game_mechanic;
        }
        return new GameMechanicEntity($this, $data);
    }


    private $_guild = null;

    // Canonical facade: $client->Guild()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->guild()
    // resolves here too.
    public function Guild($data = null)
    {
        require_once __DIR__ . '/entity/guild_entity.php';
        if ($data === null) {
            if ($this->_guild === null) {
                $this->_guild = new GuildEntity($this, null);
            }
            return $this->_guild;
        }
        return new GuildEntity($this, $data);
    }


    private $_guild_authenticated = null;

    // Canonical facade: $client->GuildAuthenticated()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->guild_authenticated()
    // resolves here too.
    public function GuildAuthenticated($data = null)
    {
        require_once __DIR__ . '/entity/guild_authenticated_entity.php';
        if ($data === null) {
            if ($this->_guild_authenticated === null) {
                $this->_guild_authenticated = new GuildAuthenticatedEntity($this, null);
            }
            return $this->_guild_authenticated;
        }
        return new GuildAuthenticatedEntity($this, $data);
    }


    private $_home_instance = null;

    // Canonical facade: $client->HomeInstance()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->home_instance()
    // resolves here too.
    public function HomeInstance($data = null)
    {
        require_once __DIR__ . '/entity/home_instance_entity.php';
        if ($data === null) {
            if ($this->_home_instance === null) {
                $this->_home_instance = new HomeInstanceEntity($this, null);
            }
            return $this->_home_instance;
        }
        return new HomeInstanceEntity($this, $data);
    }


    private $_item = null;

    // Canonical facade: $client->Item()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->item()
    // resolves here too.
    public function Item($data = null)
    {
        require_once __DIR__ . '/entity/item_entity.php';
        if ($data === null) {
            if ($this->_item === null) {
                $this->_item = new ItemEntity($this, null);
            }
            return $this->_item;
        }
        return new ItemEntity($this, $data);
    }


    private $_map = null;

    // Canonical facade: $client->Map()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->map()
    // resolves here too.
    public function Map($data = null)
    {
        require_once __DIR__ . '/entity/map_entity.php';
        if ($data === null) {
            if ($this->_map === null) {
                $this->_map = new MapEntity($this, null);
            }
            return $this->_map;
        }
        return new MapEntity($this, $data);
    }


    private $_map_information = null;

    // Canonical facade: $client->MapInformation()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->map_information()
    // resolves here too.
    public function MapInformation($data = null)
    {
        require_once __DIR__ . '/entity/map_information_entity.php';
        if ($data === null) {
            if ($this->_map_information === null) {
                $this->_map_information = new MapInformationEntity($this, null);
            }
            return $this->_map_information;
        }
        return new MapInformationEntity($this, $data);
    }


    private $_miscellaneous = null;

    // Canonical facade: $client->Miscellaneous()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->miscellaneous()
    // resolves here too.
    public function Miscellaneous($data = null)
    {
        require_once __DIR__ . '/entity/miscellaneous_entity.php';
        if ($data === null) {
            if ($this->_miscellaneous === null) {
                $this->_miscellaneous = new MiscellaneousEntity($this, null);
            }
            return $this->_miscellaneous;
        }
        return new MiscellaneousEntity($this, $data);
    }


    private $_story = null;

    // Canonical facade: $client->Story()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->story()
    // resolves here too.
    public function Story($data = null)
    {
        require_once __DIR__ . '/entity/story_entity.php';
        if ($data === null) {
            if ($this->_story === null) {
                $this->_story = new StoryEntity($this, null);
            }
            return $this->_story;
        }
        return new StoryEntity($this, $data);
    }


    private $_structured_pv_p = null;

    // Canonical facade: $client->StructuredPvP()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->structured_pv_p()
    // resolves here too.
    public function StructuredPvP($data = null)
    {
        require_once __DIR__ . '/entity/structured_pv_p_entity.php';
        if ($data === null) {
            if ($this->_structured_pv_p === null) {
                $this->_structured_pv_p = new StructuredPvPEntity($this, null);
            }
            return $this->_structured_pv_p;
        }
        return new StructuredPvPEntity($this, $data);
    }


    private $_trading_post = null;

    // Canonical facade: $client->TradingPost()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->trading_post()
    // resolves here too.
    public function TradingPost($data = null)
    {
        require_once __DIR__ . '/entity/trading_post_entity.php';
        if ($data === null) {
            if ($this->_trading_post === null) {
                $this->_trading_post = new TradingPostEntity($this, null);
            }
            return $this->_trading_post;
        }
        return new TradingPostEntity($this, $data);
    }


    private $_world_vs_world = null;

    // Canonical facade: $client->WorldVsWorld()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->world_vs_world()
    // resolves here too.
    public function WorldVsWorld($data = null)
    {
        require_once __DIR__ . '/entity/world_vs_world_entity.php';
        if ($data === null) {
            if ($this->_world_vs_world === null) {
                $this->_world_vs_world = new WorldVsWorldEntity($this, null);
            }
            return $this->_world_vs_world;
        }
        return new WorldVsWorldEntity($this, $data);
    }



    public static function test(?array $testopts = null, ?array $sdkopts = null): self
    {
        $sdkopts = $sdkopts ?? [];
        $sdkopts = Struct::clone($sdkopts);
        $sdkopts = is_array($sdkopts) ? $sdkopts : [];

        $testopts = $testopts ?? [];
        $testopts = Struct::clone($testopts);
        $testopts = is_array($testopts) ? $testopts : [];
        $testopts["active"] = true;

        if (!isset($sdkopts["feature"])) {
            $sdkopts["feature"] = [];
        }
        $sdkopts["feature"]["test"] = $testopts;

        $sdk = new GuildWars2SDK($sdkopts);
        $sdk->mode = "test";
        return $sdk;
    }
}
