<?php
declare(strict_types=1);

// GameMechanic entity test

require_once __DIR__ . '/../guildwars2_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class GameMechanicEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = GuildWars2SDK::test(null, null);
        $ent = $testsdk->GameMechanic(null);
        $this->assertNotNull($ent);
    }

    // Feature #4: the entity stream(action, ...) method runs the op pipeline
    // and yields result items. With the streaming feature active it yields the
    // feature's incremental output; otherwise it falls back to the materialised
    // list so stream always yields.
    public function test_stream(): void
    {
        $seed = [
            "entity" => [
                "game_mechanic" => [
                    "s1" => ["id" => "s1"],
                    "s2" => ["id" => "s2"],
                    "s3" => ["id" => "s3"],
                ],
            ],
        ];

        // Fallback: streaming inactive -> yields the materialised list items.
        $base = GuildWars2SDK::test($seed, null);
        $seen = iterator_to_array($base->GameMechanic(null)->stream("list", null, null), false);
        $this->assertCount(3, $seen);

        // Inbound: streaming active -> yields each item from the feature.
        $cfg = GuildWars2Config::make_config();
        if (isset($cfg["feature"]) && is_array($cfg["feature"]) && isset($cfg["feature"]["streaming"])) {
            $sdk = GuildWars2SDK::test($seed, ["feature" => ["streaming" => ["active" => true]]]);
            $got = [];
            foreach ($sdk->GameMechanic(null)->stream("list", null, null) as $item) {
                if (is_array($item) && array_is_list($item)) {
                    foreach ($item as $sub) {
                        $got[] = $sub;
                    }
                } else {
                    $got[] = $item;
                }
            }
            $this->assertCount(3, $got);
        }
    }

    public function test_basic_flow(): void
    {
        $setup = game_mechanic_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["list"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "game_mechanic." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_GAME_MECHANIC_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // Bootstrap entity data from existing test data.
        $game_mechanic_ref01_data_raw = Vs::items(Helpers::to_map(
            Vs::getpath($setup["data"], "existing.game_mechanic")));
        $game_mechanic_ref01_data = null;
        if (count($game_mechanic_ref01_data_raw) > 0) {
            $game_mechanic_ref01_data = Helpers::to_map($game_mechanic_ref01_data_raw[0][1]);
        }

        // LIST
        $game_mechanic_ref01_ent = $client->GameMechanic(null);
        $game_mechanic_ref01_match = [];

        $game_mechanic_ref01_list_result = $game_mechanic_ref01_ent->list($game_mechanic_ref01_match, null);
        $this->assertIsArray($game_mechanic_ref01_list_result);

    }
}

function game_mechanic_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/game_mechanic/GameMechanicTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = GuildWars2SDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["game_mechanic01", "game_mechanic02", "game_mechanic03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("GUILDWARS__TEST_GAME_MECHANIC_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "GUILDWARS__TEST_GAME_MECHANIC_ENTID" => $idmap,
        "GUILDWARS__TEST_LIVE" => "FALSE",
        "GUILDWARS__TEST_EXPLAIN" => "FALSE",
        "GUILDWARS__APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["GUILDWARS__TEST_GAME_MECHANIC_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["GUILDWARS__TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["GUILDWARS__APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new GuildWars2SDK(Helpers::to_map($merged_opts));
    }

    $live = $env["GUILDWARS__TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["GUILDWARS__TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
