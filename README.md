# GuildWars2 SDK



Available for [Golang](go/) and [Lua](lua/) and [PHP](php/) and [Python](py/) and [Ruby](rb/) and [TypeScript](ts/).


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

Each entity supports the following operations where available: **load**, **list**, **create**,
**update**, and **remove**.


## Architecture

### Entity-operation model

Every SDK call follows the same pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

At each stage a feature hook fires (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), allowing features to inspect or modify the pipeline.

### Features

Features are hook-based middleware that extend SDK behaviour.

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

You can add custom features by passing them in the `extend` option at
construction time.

### Direct and Prepare

For endpoints not covered by the entity model, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`, `headers`,
and `body`.


## Quick start

### Golang

```go
import sdk "github.com/voxgig-sdk/guild-wars2-sdk"

client := sdk.NewGuildWars2SDK(map[string]any{
    "apikey": os.Getenv("GUILD-WARS2_APIKEY"),
})

// List all achievements
achievements, err := client.Achievement(nil).List(nil, nil)
```

### Lua

```lua
local sdk = require("guild-wars2_sdk")

local client = sdk.new({
  apikey = os.getenv("GUILD-WARS2_APIKEY"),
})

-- List all achievements
local achievements, err = client:Achievement(nil):list(nil, nil)

-- Load a specific achievement
local achievement, err = client:Achievement(nil):load(
  { id = "example_id" }, nil
)
```

### PHP

```php
<?php
require_once 'guildwars2_sdk.php';

$client = new GuildWars2SDK([
    "apikey" => getenv("GUILD-WARS2_APIKEY"),
]);

// List all achievements
[$achievements, $err] = $client->Achievement(null)->list(null, null);

// Load a specific achievement
[$achievement, $err] = $client->Achievement(null)->load(
    ["id" => "example_id"], null
);
```

### Python

```python
import os
from guildwars2_sdk import GuildWars2SDK

client = GuildWars2SDK({
    "apikey": os.environ.get("GUILD-WARS2_APIKEY"),
})

# List all achievements
achievements, err = client.Achievement(None).list(None, None)

# Load a specific achievement
achievement, err = client.Achievement(None).load(
    {"id": "example_id"}, None
)
```

### Ruby

```ruby
require_relative "GuildWars2_sdk"

client = GuildWars2SDK.new({
  "apikey" => ENV["GUILD-WARS2_APIKEY"],
})

# List all achievements
achievements, err = client.Achievement(nil).list(nil, nil)

# Load a specific achievement
achievement, err = client.Achievement(nil).load(
  { "id" => "example_id" }, nil
)
```

### TypeScript

```ts
import { GuildWars2SDK } from 'guild-wars2'

const client = new GuildWars2SDK({
  apikey: process.env.GUILD-WARS2_APIKEY,
})

// List all achievements
const achievements = await client.Achievement().list()
```


## Testing

Both SDKs provide a test mode that replaces the HTTP transport with an
in-memory mock, so tests run without a network connection.

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Achievement(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Achievement(nil):load(
  { id = "test01" }, nil
)
```

### PHP

```php
$client = GuildWars2SDK::test(null, null);
[$result, $err] = $client->Achievement(null)->load(
    ["id" => "test01"], null
);
```

### Python

```python
client = GuildWars2SDK.test(None, None)
result, err = client.Achievement(None).load(
    {"id": "test01"}, None
)
```

### Ruby

```ruby
client = GuildWars2SDK.test(nil, nil)
result, err = client.Achievement(nil).load(
  { "id" => "test01" }, nil
)
```

### TypeScript

```ts
const client = GuildWars2SDK.test()
const result = await client.Achievement().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```


## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
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

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
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

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```


## Language-specific documentation

- [Golang SDK](go/README.md)
- [Lua SDK](lua/README.md)
- [PHP SDK](php/README.md)
- [Python SDK](py/README.md)
- [Ruby SDK](rb/README.md)
- [TypeScript SDK](ts/README.md)

