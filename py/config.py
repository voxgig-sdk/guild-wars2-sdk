# GuildWars2 SDK configuration


def make_config():
    return {
        "main": {
            "name": "GuildWars2",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
      },
        },
        "options": {
            "base": "https://api.guildwars2.com/v2",
            "auth": {
                "prefix": "Bearer",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "achievement": {},
                "authenticated": {},
                "daily_reward": {},
                "game_mechanic": {},
                "guild": {},
                "guild_authenticated": {},
                "home_instance": {},
                "item": {},
                "map": {},
                "map_information": {},
                "miscellaneous": {},
                "story": {},
                "structured_pv_p": {},
                "trading_post": {},
                "world_vs_world": {},
            },
        },
        "entity": {
      "achievement": {
        "fields": [],
        "name": "achievement",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "v",
                      "orig": "v",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/achievements",
                "parts": [
                  "achievements",
                ],
                "select": {
                  "exist": [
                    "ids",
                    "v",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/achievements/categories",
                "parts": [
                  "achievements",
                  "categories",
                ],
                "select": {
                  "$action": "category",
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/achievements/groups",
                "parts": [
                  "achievements",
                  "groups",
                ],
                "select": {
                  "$action": "group",
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
            ],
            "key$": "list",
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/achievements/daily",
                "parts": [
                  "achievements",
                  "daily",
                ],
                "select": {
                  "$action": "daily",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/achievements/daily/tomorrow",
                "parts": [
                  "achievements",
                  "daily",
                  "tomorrow",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "authenticated": {
        "fields": [
          {
            "active": True,
            "name": "created",
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "id",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "permission",
            "req": False,
            "type": "`$ARRAY`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "subtoken",
            "req": False,
            "type": "`$STRING`",
            "index$": 4,
          },
          {
            "active": True,
            "name": "value",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 5,
          },
          {
            "active": True,
            "name": "world",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 6,
          },
        ],
        "name": "authenticated",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/characters",
                "parts": [
                  "characters",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/achievements",
                "parts": [
                  "account",
                  "achievements",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/bank",
                "parts": [
                  "account",
                  "bank",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/buildstorage",
                "parts": [
                  "account",
                  "buildstorage",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/dailycrafting",
                "parts": [
                  "account",
                  "dailycrafting",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/dungeons",
                "parts": [
                  "account",
                  "dungeons",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 5,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/dyes",
                "parts": [
                  "account",
                  "dyes",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 6,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/emotes",
                "parts": [
                  "account",
                  "emotes",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 7,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/finishers",
                "parts": [
                  "account",
                  "finishers",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 8,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/gliders",
                "parts": [
                  "account",
                  "gliders",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 9,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/home/cats",
                "parts": [
                  "account",
                  "home",
                  "cats",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 10,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/home/nodes",
                "parts": [
                  "account",
                  "home",
                  "nodes",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 11,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/inventory",
                "parts": [
                  "account",
                  "inventory",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 12,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/legendaryarmory",
                "parts": [
                  "account",
                  "legendaryarmory",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 13,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/luck",
                "parts": [
                  "account",
                  "luck",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 14,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/mapchests",
                "parts": [
                  "account",
                  "mapchests",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 15,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/masteries",
                "parts": [
                  "account",
                  "masteries",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 16,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/materials",
                "parts": [
                  "account",
                  "materials",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 17,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/minis",
                "parts": [
                  "account",
                  "minis",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 18,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/mounts/skins",
                "parts": [
                  "account",
                  "mounts",
                  "skins",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 19,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/mounts/types",
                "parts": [
                  "account",
                  "mounts",
                  "types",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 20,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/novelties",
                "parts": [
                  "account",
                  "novelties",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 21,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/outfits",
                "parts": [
                  "account",
                  "outfits",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 22,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/pvp/heroes",
                "parts": [
                  "account",
                  "pvp",
                  "heroes",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 23,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/raids",
                "parts": [
                  "account",
                  "raids",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 24,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/recipes",
                "parts": [
                  "account",
                  "recipes",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 25,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/skins",
                "parts": [
                  "account",
                  "skins",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 26,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/titles",
                "parts": [
                  "account",
                  "titles",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 27,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/wallet",
                "parts": [
                  "account",
                  "wallet",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 28,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/worldbosses",
                "parts": [
                  "account",
                  "worldbosses",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 29,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/pvp/games",
                "parts": [
                  "pvp",
                  "games",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 30,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/pvp/standings",
                "parts": [
                  "pvp",
                  "standings",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 31,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/tokeninfo",
                "parts": [
                  "tokeninfo",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 32,
              },
            ],
            "key$": "list",
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "expire",
                      "orig": "expire",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "permission",
                      "orig": "permission",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "url",
                      "orig": "url",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/createsubtoken",
                "parts": [
                  "createsubtoken",
                ],
                "select": {
                  "exist": [
                    "expire",
                    "permission",
                    "url",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account",
                "parts": [
                  "account",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/account/mastery/points",
                "parts": [
                  "account",
                  "mastery",
                  "points",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/pvp/stats",
                "parts": [
                  "pvp",
                  "stats",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
            ],
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "daily_reward": {
        "fields": [],
        "name": "daily_reward",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/dailycrafting",
                "parts": [
                  "dailycrafting",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/mapchests",
                "parts": [
                  "mapchests",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/worldbosses",
                "parts": [
                  "worldbosses",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "game_mechanic": {
        "fields": [],
        "name": "game_mechanic",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/legendaryarmory",
                "parts": [
                  "legendaryarmory",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/legends",
                "parts": [
                  "legends",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/masteries",
                "parts": [
                  "masteries",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/mounts/skins",
                "parts": [
                  "mounts",
                  "skins",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/mounts/types",
                "parts": [
                  "mounts",
                  "types",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/outfits",
                "parts": [
                  "outfits",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 5,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/pets",
                "parts": [
                  "pets",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 6,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/professions",
                "parts": [
                  "professions",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 7,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/races",
                "parts": [
                  "races",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 8,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/skills",
                "parts": [
                  "skills",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 9,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/specializations",
                "parts": [
                  "specializations",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 10,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/traits",
                "parts": [
                  "traits",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 11,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/mounts",
                "parts": [
                  "mounts",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 12,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "guild": {
        "fields": [],
        "name": "guild",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/permissions",
                "parts": [
                  "guild",
                  "permissions",
                ],
                "select": {
                  "$action": "permission",
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "name",
                      "orig": "name",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/search",
                "parts": [
                  "guild",
                  "search",
                ],
                "select": {
                  "$action": "search",
                  "exist": [
                    "name",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/upgrades",
                "parts": [
                  "guild",
                  "upgrades",
                ],
                "select": {
                  "$action": "upgrade",
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/emblem",
                "parts": [
                  "emblem",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
            ],
            "key$": "list",
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}",
                "parts": [
                  "guild",
                  "{id}",
                ],
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "guild_authenticated": {
        "fields": [],
        "name": "guild_authenticated",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/log",
                "parts": [
                  "guild",
                  "{id}",
                  "log",
                ],
                "select": {
                  "$action": "log",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/members",
                "parts": [
                  "guild",
                  "{id}",
                  "members",
                ],
                "select": {
                  "$action": "members",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/ranks",
                "parts": [
                  "guild",
                  "{id}",
                  "ranks",
                ],
                "select": {
                  "$action": "ranks",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/stash",
                "parts": [
                  "guild",
                  "{id}",
                  "stash",
                ],
                "select": {
                  "$action": "stash",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/storage",
                "parts": [
                  "guild",
                  "{id}",
                  "storage",
                ],
                "select": {
                  "$action": "storage",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/teams",
                "parts": [
                  "guild",
                  "{id}",
                  "teams",
                ],
                "select": {
                  "$action": "teams",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 5,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/treasury",
                "parts": [
                  "guild",
                  "{id}",
                  "treasury",
                ],
                "select": {
                  "$action": "treasury",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 6,
              },
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "kind": "param",
                      "name": "id",
                      "orig": "id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/guild/{id}/upgrades",
                "parts": [
                  "guild",
                  "{id}",
                  "upgrades",
                ],
                "select": {
                  "$action": "upgrades",
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 7,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "home_instance": {
        "fields": [],
        "name": "home_instance",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/home/cats",
                "parts": [
                  "home",
                  "cats",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/home/nodes",
                "parts": [
                  "home",
                  "nodes",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "item": {
        "fields": [],
        "name": "item",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "input",
                      "orig": "input",
                      "reqd": False,
                      "type": "`$INTEGER`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "output",
                      "orig": "output",
                      "reqd": False,
                      "type": "`$INTEGER`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/recipes/search",
                "parts": [
                  "recipes",
                  "search",
                ],
                "select": {
                  "exist": [
                    "input",
                    "output",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/finishers",
                "parts": [
                  "finishers",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/gliders",
                "parts": [
                  "gliders",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/items",
                "parts": [
                  "items",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/itemstats",
                "parts": [
                  "itemstats",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/materials",
                "parts": [
                  "materials",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 5,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/pvp/amulets",
                "parts": [
                  "pvp",
                  "amulets",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 6,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/recipes",
                "parts": [
                  "recipes",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 7,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/skins",
                "parts": [
                  "skins",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 8,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "map": {
        "fields": [],
        "name": "map",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/maps",
                "parts": [
                  "maps",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "map_information": {
        "fields": [],
        "name": "map_information",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/continents",
                "parts": [
                  "continents",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "miscellaneous": {
        "fields": [
          {
            "active": True,
            "name": "id",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 0,
          },
        ],
        "name": "miscellaneous",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/colors",
                "parts": [
                  "colors",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/currencies",
                "parts": [
                  "currencies",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/dungeons",
                "parts": [
                  "dungeons",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/files",
                "parts": [
                  "files",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/minis",
                "parts": [
                  "minis",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/novelties",
                "parts": [
                  "novelties",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 5,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/raids",
                "parts": [
                  "raids",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 6,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/titles",
                "parts": [
                  "titles",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 7,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/worlds",
                "parts": [
                  "worlds",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 8,
              },
            ],
            "key$": "list",
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/build",
                "parts": [
                  "build",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "story": {
        "fields": [],
        "name": "story",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/quests",
                "parts": [
                  "quests",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/stories",
                "parts": [
                  "stories",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/stories/seasons",
                "parts": [
                  "stories",
                  "seasons",
                ],
                "select": {
                  "$action": "season",
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "structured_pv_p": {
        "fields": [],
        "name": "structured_pv_p",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/pvp/heroes",
                "parts": [
                  "pvp",
                  "heroes",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/pvp/ranks",
                "parts": [
                  "pvp",
                  "ranks",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/pvp/seasons",
                "parts": [
                  "pvp",
                  "seasons",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/pvp",
                "parts": [
                  "pvp",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "trading_post": {
        "fields": [
          {
            "active": True,
            "name": "coin",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "coins_per_gem",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "item",
            "req": False,
            "type": "`$ARRAY`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "quantity",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 3,
          },
        ],
        "name": "trading_post",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/commerce/listings",
                "parts": [
                  "commerce",
                  "listings",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/commerce/prices",
                "parts": [
                  "commerce",
                  "prices",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/commerce/delivery",
                "parts": [
                  "commerce",
                  "delivery",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/commerce/exchange",
                "parts": [
                  "commerce",
                  "exchange",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/commerce/transactions",
                "parts": [
                  "commerce",
                  "transactions",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
            ],
            "key$": "list",
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "quantity",
                      "orig": "quantity",
                      "reqd": True,
                      "type": "`$INTEGER`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/commerce/exchange/coins",
                "parts": [
                  "commerce",
                  "exchange",
                  "coins",
                ],
                "select": {
                  "exist": [
                    "quantity",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "quantity",
                      "orig": "quantity",
                      "reqd": True,
                      "type": "`$INTEGER`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/commerce/exchange/gems",
                "parts": [
                  "commerce",
                  "exchange",
                  "gems",
                ],
                "select": {
                  "exist": [
                    "quantity",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "world_vs_world": {
        "fields": [],
        "name": "world_vs_world",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/wvw/abilities",
                "parts": [
                  "wvw",
                  "abilities",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/wvw/matches",
                "parts": [
                  "wvw",
                  "matches",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/wvw/objectives",
                "parts": [
                  "wvw",
                  "objectives",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/wvw/ranks",
                "parts": [
                  "wvw",
                  "ranks",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 3,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "ids",
                      "orig": "ids",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/wvw/upgrades",
                "parts": [
                  "wvw",
                  "upgrades",
                ],
                "select": {
                  "exist": [
                    "ids",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 4,
              },
              {
                "active": True,
                "args": {},
                "method": "GET",
                "orig": "/wvw",
                "parts": [
                  "wvw",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 5,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
