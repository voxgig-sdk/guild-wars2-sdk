# GuildWars2 SDK configuration

module GuildWars2Config
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "GuildWars2",
        "slug" => "guild-wars2",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
          "transport" => "base",
        },
      },
      "options" => {
        "base" => "https://api.guildwars2.com/v2",
        "auth" => {
          "prefix" => "Bearer",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "achievement" => {},
          "authenticated" => {},
          "daily_reward" => {},
          "game_mechanic" => {},
          "guild" => {},
          "guild_authenticated" => {},
          "home_instance" => {},
          "item" => {},
          "map" => {},
          "map_information" => {},
          "miscellaneous" => {},
          "story" => {},
          "structured_pv_p" => {},
          "trading_post" => {},
          "world_vs_world" => {},
        },
      },
      "entity" => {
        "achievement" => {
          "fields" => [],
          "name" => "achievement",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "v",
                        "orig" => "v",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/achievements",
                  "segments" => [
                    {
                      "lit" => "achievements",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                      "v",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "achievements",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/achievements/categories",
                  "segments" => [
                    {
                      "lit" => "achievements",
                    },
                    {
                      "lit" => "categories",
                    },
                  ],
                  "select" => {
                    "$action" => "category",
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "achievements",
                    "categories",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/achievements/groups",
                  "segments" => [
                    {
                      "lit" => "achievements",
                    },
                    {
                      "lit" => "groups",
                    },
                  ],
                  "select" => {
                    "$action" => "group",
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "achievements",
                    "groups",
                  ],
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/achievements/daily",
                  "segments" => [
                    {
                      "lit" => "achievements",
                    },
                    {
                      "lit" => "daily",
                    },
                  ],
                  "select" => {
                    "$action" => "daily",
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "achievements",
                    "daily",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/achievements/daily/tomorrow",
                  "segments" => [
                    {
                      "lit" => "achievements",
                    },
                    {
                      "lit" => "daily",
                    },
                    {
                      "lit" => "tomorrow",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "achievements",
                    "daily",
                    "tomorrow",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "authenticated" => {
          "fields" => [
            {
              "format" => "date-time",
              "name" => "created",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "type" => "`$STRING`",
            },
            {
              "name" => "permissions",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "subtoken",
              "type" => "`$STRING`",
            },
            {
              "name" => "value",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "world",
              "type" => "`$INTEGER`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "authenticated",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/characters",
                  "segments" => [
                    {
                      "lit" => "characters",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "characters",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/achievements",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "achievements",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "achievements",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/bank",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "bank",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "bank",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/buildstorage",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "buildstorage",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "buildstorage",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/dailycrafting",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "dailycrafting",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "dailycrafting",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/dungeons",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "dungeons",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "dungeons",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/dyes",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "dyes",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "dyes",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/emotes",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "emotes",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "emotes",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/finishers",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "finishers",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "finishers",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/gliders",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "gliders",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "gliders",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/home/cats",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "home",
                    },
                    {
                      "lit" => "cats",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "home",
                    "cats",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/home/nodes",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "home",
                    },
                    {
                      "lit" => "nodes",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "home",
                    "nodes",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/inventory",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "inventory",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "inventory",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/legendaryarmory",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "legendaryarmory",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "legendaryarmory",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/luck",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "luck",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "luck",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/mapchests",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "mapchests",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "mapchests",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/masteries",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "masteries",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "masteries",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/materials",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "materials",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "materials",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/minis",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "minis",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "minis",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/mounts/skins",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "mounts",
                    },
                    {
                      "lit" => "skins",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "mounts",
                    "skins",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/mounts/types",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "mounts",
                    },
                    {
                      "lit" => "types",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "mounts",
                    "types",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/novelties",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "novelties",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "novelties",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/outfits",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "outfits",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "outfits",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/pvp/heroes",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "heroes",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "pvp",
                    "heroes",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/raids",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "raids",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "raids",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/recipes",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "recipes",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "recipes",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/skins",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "skins",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "skins",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/titles",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "titles",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "titles",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/wallet",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "wallet",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "wallet",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/worldbosses",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "worldbosses",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "worldbosses",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/games",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "games",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "games",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/standings",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "standings",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "standings",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/tokeninfo",
                  "segments" => [
                    {
                      "lit" => "tokeninfo",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.permissions`",
                  },
                  "parts" => [
                    "tokeninfo",
                  ],
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "expire",
                        "orig" => "expire",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "permission",
                        "orig" => "permission",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "url",
                        "orig" => "url",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/createsubtoken",
                  "segments" => [
                    {
                      "lit" => "createsubtoken",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "expire",
                      "permission",
                      "url",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "createsubtoken",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/account/mastery/points",
                  "segments" => [
                    {
                      "lit" => "account",
                    },
                    {
                      "lit" => "mastery",
                    },
                    {
                      "lit" => "points",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "account",
                    "mastery",
                    "points",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/stats",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "stats",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "stats",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "daily_reward" => {
          "fields" => [],
          "name" => "daily_reward",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/dailycrafting",
                  "segments" => [
                    {
                      "lit" => "dailycrafting",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "dailycrafting",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/mapchests",
                  "segments" => [
                    {
                      "lit" => "mapchests",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "mapchests",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/worldbosses",
                  "segments" => [
                    {
                      "lit" => "worldbosses",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "worldbosses",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "game_mechanic" => {
          "fields" => [],
          "name" => "game_mechanic",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/legendaryarmory",
                  "segments" => [
                    {
                      "lit" => "legendaryarmory",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "legendaryarmory",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/legends",
                  "segments" => [
                    {
                      "lit" => "legends",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "legends",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/masteries",
                  "segments" => [
                    {
                      "lit" => "masteries",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "masteries",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/mounts/skins",
                  "segments" => [
                    {
                      "lit" => "mounts",
                    },
                    {
                      "lit" => "skins",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "mounts",
                    "skins",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/mounts/types",
                  "segments" => [
                    {
                      "lit" => "mounts",
                    },
                    {
                      "lit" => "types",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "mounts",
                    "types",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/outfits",
                  "segments" => [
                    {
                      "lit" => "outfits",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "outfits",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pets",
                  "segments" => [
                    {
                      "lit" => "pets",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pets",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/professions",
                  "segments" => [
                    {
                      "lit" => "professions",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "professions",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/races",
                  "segments" => [
                    {
                      "lit" => "races",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "races",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/skills",
                  "segments" => [
                    {
                      "lit" => "skills",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "skills",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/specializations",
                  "segments" => [
                    {
                      "lit" => "specializations",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "specializations",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/traits",
                  "segments" => [
                    {
                      "lit" => "traits",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "traits",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/mounts",
                  "segments" => [
                    {
                      "lit" => "mounts",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "mounts",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "guild" => {
          "fields" => [
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "guild",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/permissions",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "lit" => "permissions",
                    },
                  ],
                  "select" => {
                    "$action" => "permission",
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "permissions",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "name",
                        "orig" => "name",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/search",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "lit" => "search",
                    },
                  ],
                  "select" => {
                    "$action" => "search",
                    "exist" => [
                      "name",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "search",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/upgrades",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "lit" => "upgrades",
                    },
                  ],
                  "select" => {
                    "$action" => "upgrade",
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "upgrades",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/emblem",
                  "segments" => [
                    {
                      "lit" => "emblem",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "emblem",
                  ],
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "guild_authenticated" => {
          "fields" => [
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "guild_authenticated",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/log",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "log",
                    },
                  ],
                  "select" => {
                    "$action" => "log",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "log",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/members",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "members",
                    },
                  ],
                  "select" => {
                    "$action" => "members",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "members",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/ranks",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "ranks",
                    },
                  ],
                  "select" => {
                    "$action" => "ranks",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "ranks",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/stash",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "stash",
                    },
                  ],
                  "select" => {
                    "$action" => "stash",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "stash",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/storage",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "storage",
                    },
                  ],
                  "select" => {
                    "$action" => "storage",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "storage",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/teams",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "teams",
                    },
                  ],
                  "select" => {
                    "$action" => "teams",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "teams",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/treasury",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "treasury",
                    },
                  ],
                  "select" => {
                    "$action" => "treasury",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "treasury",
                  ],
                },
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/guild/{id}/upgrades",
                  "segments" => [
                    {
                      "lit" => "guild",
                    },
                    {
                      "var" => "id",
                    },
                    {
                      "lit" => "upgrades",
                    },
                  ],
                  "select" => {
                    "$action" => "upgrades",
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "guild",
                    "{id}",
                    "upgrades",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "home_instance" => {
          "fields" => [],
          "name" => "home_instance",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/home/cats",
                  "segments" => [
                    {
                      "lit" => "home",
                    },
                    {
                      "lit" => "cats",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "home",
                    "cats",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/home/nodes",
                  "segments" => [
                    {
                      "lit" => "home",
                    },
                    {
                      "lit" => "nodes",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "home",
                    "nodes",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "item" => {
          "fields" => [],
          "name" => "item",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "input",
                        "orig" => "input",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "output",
                        "orig" => "output",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/recipes/search",
                  "segments" => [
                    {
                      "lit" => "recipes",
                    },
                    {
                      "lit" => "search",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "input",
                      "output",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "recipes",
                    "search",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/finishers",
                  "segments" => [
                    {
                      "lit" => "finishers",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "finishers",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/gliders",
                  "segments" => [
                    {
                      "lit" => "gliders",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "gliders",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/items",
                  "segments" => [
                    {
                      "lit" => "items",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "items",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/itemstats",
                  "segments" => [
                    {
                      "lit" => "itemstats",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "itemstats",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/materials",
                  "segments" => [
                    {
                      "lit" => "materials",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "materials",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/amulets",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "amulets",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "amulets",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/recipes",
                  "segments" => [
                    {
                      "lit" => "recipes",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "recipes",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/skins",
                  "segments" => [
                    {
                      "lit" => "skins",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "skins",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "map" => {
          "fields" => [],
          "name" => "map",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/maps",
                  "segments" => [
                    {
                      "lit" => "maps",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "maps",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "map_information" => {
          "fields" => [],
          "name" => "map_information",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/continents",
                  "segments" => [
                    {
                      "lit" => "continents",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "continents",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "miscellaneous" => {
          "fields" => [
            {
              "name" => "id",
              "type" => "`$INTEGER`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "miscellaneous",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/colors",
                  "segments" => [
                    {
                      "lit" => "colors",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "colors",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/currencies",
                  "segments" => [
                    {
                      "lit" => "currencies",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "currencies",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/dungeons",
                  "segments" => [
                    {
                      "lit" => "dungeons",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "dungeons",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/files",
                  "segments" => [
                    {
                      "lit" => "files",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "files",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/minis",
                  "segments" => [
                    {
                      "lit" => "minis",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "minis",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/novelties",
                  "segments" => [
                    {
                      "lit" => "novelties",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "novelties",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/raids",
                  "segments" => [
                    {
                      "lit" => "raids",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "raids",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/titles",
                  "segments" => [
                    {
                      "lit" => "titles",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "titles",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/worlds",
                  "segments" => [
                    {
                      "lit" => "worlds",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "worlds",
                  ],
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/build",
                  "segments" => [
                    {
                      "lit" => "build",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "build",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "story" => {
          "fields" => [],
          "name" => "story",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/quests",
                  "segments" => [
                    {
                      "lit" => "quests",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "quests",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/stories",
                  "segments" => [
                    {
                      "lit" => "stories",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "stories",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/stories/seasons",
                  "segments" => [
                    {
                      "lit" => "stories",
                    },
                    {
                      "lit" => "seasons",
                    },
                  ],
                  "select" => {
                    "$action" => "season",
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "stories",
                    "seasons",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "structured_pv_p" => {
          "fields" => [],
          "name" => "structured_pv_p",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/heroes",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "heroes",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "heroes",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/ranks",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "ranks",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "ranks",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp/seasons",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                    {
                      "lit" => "seasons",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                    "seasons",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/pvp",
                  "segments" => [
                    {
                      "lit" => "pvp",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "pvp",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "trading_post" => {
          "fields" => [
            {
              "name" => "coins",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "coins_per_gem",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "items",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "quantity",
              "type" => "`$INTEGER`",
            },
          ],
          "name" => "trading_post",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/listings",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "listings",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "commerce",
                    "listings",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/prices",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "prices",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "commerce",
                    "prices",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/delivery",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "delivery",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.items`",
                  },
                  "parts" => [
                    "commerce",
                    "delivery",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/exchange",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "exchange",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "commerce",
                    "exchange",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/transactions",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "transactions",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "commerce",
                    "transactions",
                  ],
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "quantity",
                        "orig" => "quantity",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/exchange/coins",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "exchange",
                    },
                    {
                      "lit" => "coins",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "quantity",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "commerce",
                    "exchange",
                    "coins",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "quantity",
                        "orig" => "quantity",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/commerce/exchange/gems",
                  "segments" => [
                    {
                      "lit" => "commerce",
                    },
                    {
                      "lit" => "exchange",
                    },
                    {
                      "lit" => "gems",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "quantity",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "commerce",
                    "exchange",
                    "gems",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "world_vs_world" => {
          "fields" => [],
          "name" => "world_vs_world",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/wvw/abilities",
                  "segments" => [
                    {
                      "lit" => "wvw",
                    },
                    {
                      "lit" => "abilities",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "wvw",
                    "abilities",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/wvw/matches",
                  "segments" => [
                    {
                      "lit" => "wvw",
                    },
                    {
                      "lit" => "matches",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "wvw",
                    "matches",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/wvw/objectives",
                  "segments" => [
                    {
                      "lit" => "wvw",
                    },
                    {
                      "lit" => "objectives",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "wvw",
                    "objectives",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/wvw/ranks",
                  "segments" => [
                    {
                      "lit" => "wvw",
                    },
                    {
                      "lit" => "ranks",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "wvw",
                    "ranks",
                  ],
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "ids",
                        "orig" => "ids",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/wvw/upgrades",
                  "segments" => [
                    {
                      "lit" => "wvw",
                    },
                    {
                      "lit" => "upgrades",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "ids",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "wvw",
                    "upgrades",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/wvw",
                  "segments" => [
                    {
                      "lit" => "wvw",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "wvw",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    GuildWars2Features.make_feature(name)
  end
end
