# GuildWars2 SDK

Guild Wars 2 API client, generated from the OpenAPI spec.

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

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

## Quickstart

### TypeScript

```ts
import { GuildWars2SDK } from 'guild-wars2'

const client = new GuildWars2SDK({
  apikey: process.env.GUILD-WARS2_APIKEY,
})

// List all achievements
const achievements = await client.Achievement().list()
console.log(achievements.data)
```

See the [TypeScript README](ts/README.md) for the full guide.

## Surfaces

| Surface | Path |
| --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | `go-cli/` |
| **MCP server** | `go-mcp/` |

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
| **Achievement** |  | `/achievements` |
| **Authenticated** |  | `/characters` |
| **DailyReward** |  | `/dailycrafting` |
| **GameMechanic** |  | `/legendaryarmory` |
| **Guild** |  | `/guild/permissions` |
| **GuildAuthenticated** |  | `/guild/{id}/log` |
| **HomeInstance** |  | `/home/cats` |
| **Item** |  | `/recipes/search` |
| **Map** |  | `/maps` |
| **MapInformation** |  | `/continents` |
| **Miscellaneous** |  | `/colors` |
| **Story** |  | `/quests` |
| **StructuredPvP** |  | `/pvp/heroes` |
| **TradingPost** |  | `/commerce/listings` |
| **WorldVsWorld** |  | `/wvw/abilities` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
import os
from guildwars2_sdk import GuildWars2SDK

client = GuildWars2SDK({
    "apikey": os.environ.get("GUILD-WARS2_APIKEY"),
})

# List all achievements
achievements, err = client.Achievement().list()
print(achievements)

# Load a specific achievement
achievement, err = client.Achievement().load({"id": "example_id"})
print(achievement)
```

### PHP

```php
<?php
require_once 'guildwars2_sdk.php';

$client = new GuildWars2SDK([
    "apikey" => getenv("GUILD-WARS2_APIKEY"),
]);

// List all achievements
[$achievements, $err] = $client->Achievement()->list();
print_r($achievements);

// Load a specific achievement
[$achievement, $err] = $client->Achievement()->load(["id" => "example_id"]);
print_r($achievement);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/guild-wars2-sdk/go"

client := sdk.NewGuildWars2SDK(map[string]any{
    "apikey": os.Getenv("GUILD-WARS2_APIKEY"),
})

// List all achievements
achievements, err := client.Achievement(nil).List(nil, nil)
fmt.Println(achievements)
```

### Ruby

```ruby
require_relative "GuildWars2_sdk"

client = GuildWars2SDK.new({
  "apikey" => ENV["GUILD-WARS2_APIKEY"],
})

# List all achievements
achievements, err = client.Achievement().list
puts achievements

# Load a specific achievement
achievement, err = client.Achievement().load({ "id" => "example_id" })
puts achievement
```

### Lua

```lua
local sdk = require("guild-wars2_sdk")

local client = sdk.new({
  apikey = os.getenv("GUILD-WARS2_APIKEY"),
})

-- List all achievements
local achievements, err = client:Achievement():list()
print(achievements)

-- Load a specific achievement
local achievement, err = client:Achievement():load({ id = "example_id" })
print(achievement)
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
client = GuildWars2SDK.test()
result, err = client.Achievement().load({"id": "test01"})
```

### PHP

```php
$client = GuildWars2SDK::test();
[$result, $err] = $client->Achievement()->load(["id" => "test01"]);
```

### Golang

```go
client := sdk.Test()
result, err := client.Achievement(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = GuildWars2SDK.test
result, err = client.Achievement().load({ "id" => "test01" })
```

### Lua

```lua
local client = sdk.test()
local result, err = client:Achievement():load({ id = "test01" })
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

---

Generated from the Guild Wars 2 API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
