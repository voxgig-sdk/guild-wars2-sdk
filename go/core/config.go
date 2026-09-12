package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "GuildWars2",
			"slug": "guild-wars2",
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "base",
			},
		},
		"options": map[string]any{
			"base": "https://api.guildwars2.com/v2",
			"auth": map[string]any{
				"prefix": "Bearer",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"achievement": map[string]any{},
				"authenticated": map[string]any{},
				"daily_reward": map[string]any{},
				"game_mechanic": map[string]any{},
				"guild": map[string]any{},
				"guild_authenticated": map[string]any{},
				"home_instance": map[string]any{},
				"item": map[string]any{},
				"map": map[string]any{},
				"map_information": map[string]any{},
				"miscellaneous": map[string]any{},
				"story": map[string]any{},
				"structured_pv_p": map[string]any{},
				"trading_post": map[string]any{},
				"world_vs_world": map[string]any{},
			},
		},
		"entity": map[string]any{
			"achievement": map[string]any{
				"fields": []any{},
				"name": "achievement",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "v",
											"orig": "v",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/achievements",
								"segments": []any{
									map[string]any{
										"lit": "achievements",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
										"v",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"achievements",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/achievements/categories",
								"segments": []any{
									map[string]any{
										"lit": "achievements",
									},
									map[string]any{
										"lit": "categories",
									},
								},
								"select": map[string]any{
									"$action": "category",
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"achievements",
									"categories",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/achievements/groups",
								"segments": []any{
									map[string]any{
										"lit": "achievements",
									},
									map[string]any{
										"lit": "groups",
									},
								},
								"select": map[string]any{
									"$action": "group",
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"achievements",
									"groups",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/achievements/daily",
								"segments": []any{
									map[string]any{
										"lit": "achievements",
									},
									map[string]any{
										"lit": "daily",
									},
								},
								"select": map[string]any{
									"$action": "daily",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"achievements",
									"daily",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/achievements/daily/tomorrow",
								"segments": []any{
									map[string]any{
										"lit": "achievements",
									},
									map[string]any{
										"lit": "daily",
									},
									map[string]any{
										"lit": "tomorrow",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"achievements",
									"daily",
									"tomorrow",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"authenticated": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "date-time",
						"name": "created",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "permissions",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "subtoken",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "value",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "world",
						"type": "`$INTEGER`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "authenticated",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/characters",
								"segments": []any{
									map[string]any{
										"lit": "characters",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"characters",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/achievements",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "achievements",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"achievements",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/bank",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "bank",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"bank",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/buildstorage",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "buildstorage",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"buildstorage",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/dailycrafting",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "dailycrafting",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"dailycrafting",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/dungeons",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "dungeons",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"dungeons",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/dyes",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "dyes",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"dyes",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/emotes",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "emotes",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"emotes",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/finishers",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "finishers",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"finishers",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/gliders",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "gliders",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"gliders",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/home/cats",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "home",
									},
									map[string]any{
										"lit": "cats",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"home",
									"cats",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/home/nodes",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "home",
									},
									map[string]any{
										"lit": "nodes",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"home",
									"nodes",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/inventory",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "inventory",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"inventory",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/legendaryarmory",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "legendaryarmory",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"legendaryarmory",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/luck",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "luck",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"luck",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/mapchests",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "mapchests",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"mapchests",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/masteries",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "masteries",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"masteries",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/materials",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "materials",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"materials",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/minis",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "minis",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"minis",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/mounts/skins",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "mounts",
									},
									map[string]any{
										"lit": "skins",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"mounts",
									"skins",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/mounts/types",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "mounts",
									},
									map[string]any{
										"lit": "types",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"mounts",
									"types",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/novelties",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "novelties",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"novelties",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/outfits",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "outfits",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"outfits",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/pvp/heroes",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "heroes",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"pvp",
									"heroes",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/raids",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "raids",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"raids",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/recipes",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "recipes",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"recipes",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/skins",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "skins",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"skins",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/titles",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "titles",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"titles",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/wallet",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "wallet",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"wallet",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/worldbosses",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "worldbosses",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"worldbosses",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/games",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "games",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"games",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/standings",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "standings",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"standings",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/tokeninfo",
								"segments": []any{
									map[string]any{
										"lit": "tokeninfo",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.permissions`",
								},
								"parts": []any{
									"tokeninfo",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "expire",
											"orig": "expire",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "permission",
											"orig": "permission",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "url",
											"orig": "url",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/createsubtoken",
								"segments": []any{
									map[string]any{
										"lit": "createsubtoken",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"expire",
										"permission",
										"url",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"createsubtoken",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/account/mastery/points",
								"segments": []any{
									map[string]any{
										"lit": "account",
									},
									map[string]any{
										"lit": "mastery",
									},
									map[string]any{
										"lit": "points",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"account",
									"mastery",
									"points",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/stats",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "stats",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"stats",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"daily_reward": map[string]any{
				"fields": []any{},
				"name": "daily_reward",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/dailycrafting",
								"segments": []any{
									map[string]any{
										"lit": "dailycrafting",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"dailycrafting",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/mapchests",
								"segments": []any{
									map[string]any{
										"lit": "mapchests",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"mapchests",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/worldbosses",
								"segments": []any{
									map[string]any{
										"lit": "worldbosses",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"worldbosses",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"game_mechanic": map[string]any{
				"fields": []any{},
				"name": "game_mechanic",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/legendaryarmory",
								"segments": []any{
									map[string]any{
										"lit": "legendaryarmory",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"legendaryarmory",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/legends",
								"segments": []any{
									map[string]any{
										"lit": "legends",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"legends",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/masteries",
								"segments": []any{
									map[string]any{
										"lit": "masteries",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"masteries",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/mounts/skins",
								"segments": []any{
									map[string]any{
										"lit": "mounts",
									},
									map[string]any{
										"lit": "skins",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"mounts",
									"skins",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/mounts/types",
								"segments": []any{
									map[string]any{
										"lit": "mounts",
									},
									map[string]any{
										"lit": "types",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"mounts",
									"types",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/outfits",
								"segments": []any{
									map[string]any{
										"lit": "outfits",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"outfits",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/pets",
								"segments": []any{
									map[string]any{
										"lit": "pets",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pets",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/professions",
								"segments": []any{
									map[string]any{
										"lit": "professions",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"professions",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/races",
								"segments": []any{
									map[string]any{
										"lit": "races",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"races",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/skills",
								"segments": []any{
									map[string]any{
										"lit": "skills",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"skills",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/specializations",
								"segments": []any{
									map[string]any{
										"lit": "specializations",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"specializations",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/traits",
								"segments": []any{
									map[string]any{
										"lit": "traits",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"traits",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/mounts",
								"segments": []any{
									map[string]any{
										"lit": "mounts",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"mounts",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"guild": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "guild",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/permissions",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"lit": "permissions",
									},
								},
								"select": map[string]any{
									"$action": "permission",
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"permissions",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "name",
											"orig": "name",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/search",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"lit": "search",
									},
								},
								"select": map[string]any{
									"$action": "search",
									"exist": []any{
										"name",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"search",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/upgrades",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"lit": "upgrades",
									},
								},
								"select": map[string]any{
									"$action": "upgrade",
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"upgrades",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/emblem",
								"segments": []any{
									map[string]any{
										"lit": "emblem",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"emblem",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"guild_authenticated": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "guild_authenticated",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/log",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "log",
									},
								},
								"select": map[string]any{
									"$action": "log",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"log",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/members",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "members",
									},
								},
								"select": map[string]any{
									"$action": "members",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"members",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/ranks",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "ranks",
									},
								},
								"select": map[string]any{
									"$action": "ranks",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"ranks",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/stash",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "stash",
									},
								},
								"select": map[string]any{
									"$action": "stash",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"stash",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/storage",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "storage",
									},
								},
								"select": map[string]any{
									"$action": "storage",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"storage",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/teams",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "teams",
									},
								},
								"select": map[string]any{
									"$action": "teams",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"teams",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/treasury",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "treasury",
									},
								},
								"select": map[string]any{
									"$action": "treasury",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"treasury",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/guild/{id}/upgrades",
								"segments": []any{
									map[string]any{
										"lit": "guild",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "upgrades",
									},
								},
								"select": map[string]any{
									"$action": "upgrades",
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"guild",
									"{id}",
									"upgrades",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"home_instance": map[string]any{
				"fields": []any{},
				"name": "home_instance",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/home/cats",
								"segments": []any{
									map[string]any{
										"lit": "home",
									},
									map[string]any{
										"lit": "cats",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"home",
									"cats",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/home/nodes",
								"segments": []any{
									map[string]any{
										"lit": "home",
									},
									map[string]any{
										"lit": "nodes",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"home",
									"nodes",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"item": map[string]any{
				"fields": []any{},
				"name": "item",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "input",
											"orig": "input",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "output",
											"orig": "output",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/recipes/search",
								"segments": []any{
									map[string]any{
										"lit": "recipes",
									},
									map[string]any{
										"lit": "search",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"input",
										"output",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"recipes",
									"search",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/finishers",
								"segments": []any{
									map[string]any{
										"lit": "finishers",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"finishers",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/gliders",
								"segments": []any{
									map[string]any{
										"lit": "gliders",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"gliders",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/items",
								"segments": []any{
									map[string]any{
										"lit": "items",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"items",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/itemstats",
								"segments": []any{
									map[string]any{
										"lit": "itemstats",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"itemstats",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/materials",
								"segments": []any{
									map[string]any{
										"lit": "materials",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"materials",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/amulets",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "amulets",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"amulets",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/recipes",
								"segments": []any{
									map[string]any{
										"lit": "recipes",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"recipes",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/skins",
								"segments": []any{
									map[string]any{
										"lit": "skins",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"skins",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"map": map[string]any{
				"fields": []any{},
				"name": "map",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/maps",
								"segments": []any{
									map[string]any{
										"lit": "maps",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"maps",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"map_information": map[string]any{
				"fields": []any{},
				"name": "map_information",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/continents",
								"segments": []any{
									map[string]any{
										"lit": "continents",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"continents",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"miscellaneous": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"type": "`$INTEGER`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "miscellaneous",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/colors",
								"segments": []any{
									map[string]any{
										"lit": "colors",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"colors",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/currencies",
								"segments": []any{
									map[string]any{
										"lit": "currencies",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"currencies",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/dungeons",
								"segments": []any{
									map[string]any{
										"lit": "dungeons",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"dungeons",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/files",
								"segments": []any{
									map[string]any{
										"lit": "files",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"files",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/minis",
								"segments": []any{
									map[string]any{
										"lit": "minis",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"minis",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/novelties",
								"segments": []any{
									map[string]any{
										"lit": "novelties",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"novelties",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/raids",
								"segments": []any{
									map[string]any{
										"lit": "raids",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"raids",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/titles",
								"segments": []any{
									map[string]any{
										"lit": "titles",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"titles",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/worlds",
								"segments": []any{
									map[string]any{
										"lit": "worlds",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"worlds",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/build",
								"segments": []any{
									map[string]any{
										"lit": "build",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"build",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"story": map[string]any{
				"fields": []any{},
				"name": "story",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/quests",
								"segments": []any{
									map[string]any{
										"lit": "quests",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"quests",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/stories",
								"segments": []any{
									map[string]any{
										"lit": "stories",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"stories",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/stories/seasons",
								"segments": []any{
									map[string]any{
										"lit": "stories",
									},
									map[string]any{
										"lit": "seasons",
									},
								},
								"select": map[string]any{
									"$action": "season",
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"stories",
									"seasons",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"structured_pv_p": map[string]any{
				"fields": []any{},
				"name": "structured_pv_p",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/heroes",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "heroes",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"heroes",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/ranks",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "ranks",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"ranks",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp/seasons",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
									map[string]any{
										"lit": "seasons",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
									"seasons",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/pvp",
								"segments": []any{
									map[string]any{
										"lit": "pvp",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"pvp",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"trading_post": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "coins",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "coins_per_gem",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "items",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "quantity",
						"type": "`$INTEGER`",
					},
				},
				"name": "trading_post",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/listings",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "listings",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"commerce",
									"listings",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/prices",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "prices",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"commerce",
									"prices",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/delivery",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "delivery",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.items`",
								},
								"parts": []any{
									"commerce",
									"delivery",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/exchange",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "exchange",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"commerce",
									"exchange",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/transactions",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "transactions",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"commerce",
									"transactions",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "quantity",
											"orig": "quantity",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/exchange/coins",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "exchange",
									},
									map[string]any{
										"lit": "coins",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"quantity",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"commerce",
									"exchange",
									"coins",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "quantity",
											"orig": "quantity",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/commerce/exchange/gems",
								"segments": []any{
									map[string]any{
										"lit": "commerce",
									},
									map[string]any{
										"lit": "exchange",
									},
									map[string]any{
										"lit": "gems",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"quantity",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"commerce",
									"exchange",
									"gems",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"world_vs_world": map[string]any{
				"fields": []any{},
				"name": "world_vs_world",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/wvw/abilities",
								"segments": []any{
									map[string]any{
										"lit": "wvw",
									},
									map[string]any{
										"lit": "abilities",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"wvw",
									"abilities",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/wvw/matches",
								"segments": []any{
									map[string]any{
										"lit": "wvw",
									},
									map[string]any{
										"lit": "matches",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"wvw",
									"matches",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/wvw/objectives",
								"segments": []any{
									map[string]any{
										"lit": "wvw",
									},
									map[string]any{
										"lit": "objectives",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"wvw",
									"objectives",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/wvw/ranks",
								"segments": []any{
									map[string]any{
										"lit": "wvw",
									},
									map[string]any{
										"lit": "ranks",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"wvw",
									"ranks",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "ids",
											"orig": "ids",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/wvw/upgrades",
								"segments": []any{
									map[string]any{
										"lit": "wvw",
									},
									map[string]any{
										"lit": "upgrades",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ids",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"wvw",
									"upgrades",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/wvw",
								"segments": []any{
									map[string]any{
										"lit": "wvw",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"wvw",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
