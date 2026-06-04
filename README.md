# GuildWars2 SDK

Access live Guild Wars 2 game data — items, achievements, guilds, WvW, PvP, trading post and more — straight from ArenaNet's servers

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About Guild Wars 2 API

The Guild Wars 2 API is the official HTTP interface to game data for [Guild Wars 2](https://www.guildwars2.com/), the MMORPG developed by [ArenaNet](https://www.arena.net/). The current version, **v2**, lives at `https://api.guildwars2.com/v2` and follows a pattern where each path segment enumerates the possible values of the next segment, so a fully qualified path returns a JSON object describing one resource.

What you get from the API:

- Static game catalogue: items, skins, recipes, skills, traits, specializations, professions, masteries, mounts, pets, finishers and gliders.
- World data: continents, maps, points of interest, story content, dungeons and raids.
- Live player-scoped data (with an API key): account inventory, characters, achievements, wallet, bank, material storage, guild membership and homestead/home instance progress.
- Competitive modes: structured PvP stats, leaderboards and seasons, plus World vs. World matches, objectives and upgrades.
- Economy: trading post listings, current prices, delivery box contents and gem exchange rates.
- Daily and seasonal rewards: daily achievements, world bosses, map chests and Wizard's Vault objectives.

Most endpoints support `?lang=` for localisation (en, es, de, fr, zh) and bulk fetching via `?ids=1,2,3`, `?ids=all` or `?page=&page_size=`. Authenticated endpoints accept the key either as `Authorization: Bearer <key>` (preferred from servers) or `?access_token=<key>` (required from browsers, since CORS preflight is not supported).

## Try it

**TypeScript**
```bash
npm install guild-wars2
```

**Python**
```bash
pip install guild-wars2-sdk
```

**PHP**
```bash
composer require voxgig/guild-wars2-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/guild-wars2-sdk/go
```

**Ruby**
```bash
gem install guild-wars2-sdk
```

**Lua**
```bash
luarocks install guild-wars2-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { GuildWars2SDK } from 'guild-wars2'

const client = new GuildWars2SDK({})

// List all achievements
const achievements = await client.Achievement().list()
```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o guild-wars2-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "guild-wars2": {
      "command": "/abs/path/to/guild-wars2-mcp"
    }
  }
}
```

## Entities

The API exposes 15 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Achievement** | Achievement definitions, categories, groups and the rotating daily list — see paths under `/v2/achievements`. | `/achievements` |
| **Authenticated** | Account-scoped resources that require an API key, such as `/v2/account`, `/v2/characters`, `/v2/wallet` and related player data. | `/characters` |
| **DailyReward** | Recurring reward listings including daily crafting items, map chests and world boss rotations exposed under `/v2/dailycrafting`, `/v2/mapchests` and `/v2/worldbosses`. | `/dailycrafting` |
| **GameMechanic** | Core combat and progression systems: masteries, mounts, pets, professions, skills, traits and specializations under `/v2/masteries`, `/v2/skills`, `/v2/traits`, etc. | `/legendaryarmory` |
| **Guild** | Public guild lookup endpoints for guild info, emblems, permissions and upgrade catalogues under `/v2/guild/{id}` and `/v2/guild/permissions|upgrades|emblem`. | `/guild/permissions` |
| **GuildAuthenticated** | Guild leader / member endpoints behind an API key — members, ranks, treasury, stash, storage and logs under `/v2/guild/{id}/...`. | `/guild/{id}/log` |
| **HomeInstance** | Home instance and homestead content such as cats, nodes, decorations and glyphs under `/v2/home/...` and related homestead paths. | `/home/cats` |
| **Item** | The item catalogue plus related collectibles — items, item stats, skins, finishers, gliders, materials and recipes under `/v2/items`, `/v2/itemstats`, `/v2/skins`, `/v2/recipes`, etc. | `/recipes/search` |
| **Map** | Individual map records keyed by map id under `/v2/maps`. | `/maps` |
| **MapInformation** | Higher-level world geography — continents, floors, regions and points of interest under `/v2/continents` and friends. | `/continents` |
| **Miscellaneous** | Catch-all utility endpoints such as build number, colors, currencies, files, quaggans and titles under `/v2/build`, `/v2/colors`, `/v2/currencies`, `/v2/files`, `/v2/quaggans`, `/v2/titles`. | `/colors` |
| **Story** | Personal and Living World story content — backstory answers and questions, quests and story seasons under `/v2/stories`, `/v2/quests` and `/v2/backstory/...`. | `/quests` |
| **StructuredPvP** | Structured PvP data: ranks, heroes, amulets, seasons, leaderboards and per-account games and stats under `/v2/pvp/...`. | `/pvp/heroes` |
| **TradingPost** | Commerce endpoints for current listings, prices, transaction history, delivery box contents and gem/coin exchange rates under `/v2/commerce/...`. | `/commerce/listings` |
| **WorldVsWorld** | World vs. World mode data: matches, objectives, abilities, ranks and upgrades under `/v2/wvw/...`. | `/wvw/abilities` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from guildwars2_sdk import GuildWars2SDK

client = GuildWars2SDK({})

# List all achievements
achievements, err = client.Achievement(None).list(None, None)

# Load a specific achievement
achievement, err = client.Achievement(None).load(
    {"id": "example_id"}, None
)
```

### PHP

```php
<?php
require_once 'guildwars2_sdk.php';

$client = new GuildWars2SDK([]);

// List all achievements
[$achievements, $err] = $client->Achievement(null)->list(null, null);

// Load a specific achievement
[$achievement, $err] = $client->Achievement(null)->load(
    ["id" => "example_id"], null
);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/guild-wars2-sdk/go"

client := sdk.NewGuildWars2SDK(map[string]any{})

// List all achievements
achievements, err := client.Achievement(nil).List(nil, nil)
```

### Ruby

```ruby
require_relative "GuildWars2_sdk"

client = GuildWars2SDK.new({})

# List all achievements
achievements, err = client.Achievement(nil).list(nil, nil)

# Load a specific achievement
achievement, err = client.Achievement(nil).load(
  { "id" => "example_id" }, nil
)
```

### Lua

```lua
local sdk = require("guild-wars2_sdk")

local client = sdk.new({})

-- List all achievements
local achievements, err = client:Achievement(nil):list(nil, nil)

-- Load a specific achievement
local achievement, err = client:Achievement(nil):load(
  { id = "example_id" }, nil
)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = GuildWars2SDK.test()
const result = await client.Achievement().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = GuildWars2SDK.test(None, None)
result, err = client.Achievement(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = GuildWars2SDK::test(null, null);
[$result, $err] = $client->Achievement(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Achievement(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = GuildWars2SDK.test(nil, nil)
result, err = client.Achievement(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Achievement(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the Guild Wars 2 API

- Upstream: [https://api.guildwars2.com/v2](https://api.guildwars2.com/v2)
- API docs: [https://wiki.guildwars2.com/wiki/API:Main](https://wiki.guildwars2.com/wiki/API:Main)

- The API is operated by [ArenaNet](https://www.arena.net/) for the MMO Guild Wars 2; using it constitutes acceptance of ArenaNet's Content Terms of Use and Website Terms of Use.
- Public game data (items, maps, achievements, etc.) is generally redistributable for fan tools, but trademarks, art, and other ArenaNet assets remain ArenaNet's property.
- Account, character, guild, and other player-scoped endpoints require an API key issued from the player's ArenaNet account, with scopes the player has explicitly granted.
- No formal SLA or open-source licence is published for the API itself; check the [official wiki](https://wiki.guildwars2.com/wiki/API:Main) for the current terms before shipping a product.

---

Generated from the Guild Wars 2 API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
