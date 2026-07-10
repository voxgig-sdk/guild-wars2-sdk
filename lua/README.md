# GuildWars2 Lua SDK



The Lua SDK for the GuildWars2 API — an entity-oriented client using Lua conventions.

It exposes the API as capitalised, semantic **Entities** — e.g. `client:Achievement()` — each with the same small set of operations (`list`, `load`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to LuaRocks. Install it from the
GitHub release tag (`lua/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/guild-wars2-sdk/releases)),
or add the source directory to your `LUA_PATH`:

```bash
export LUA_PATH="path/to/lua/?.lua;path/to/lua/?/init.lua;;"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```lua
local sdk = require("guild-wars2_sdk")

local client = sdk.new({
  apikey = os.getenv("GUILD_WARS2_APIKEY"),
})
```

### 2. List achievement records

Entity operations return `(value, err)`. For `list`, `value` is the
array of records itself — iterate it directly (there is no wrapper).

```lua
local achievements, err = client:Achievement():list()
if err then error(err) end

for _, item in ipairs(achievements) do
  print(item)
end
```

### 3. Load an achievement

```lua
local achievement, err = client:Achievement():load()
if err then error(err) end
print(achievement)
```


## Error handling

Entity operations return `(value, err)`. Check `err` before using
the value:

```lua
local achievements, err = client:Achievement():list()
if err then error(err) end
```

`direct` follows the same `(value, err)` convention:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example_id" },
})
if err then error(err) end
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
if err then error(err) end

if result["ok"] then
  print(result["status"])  -- 200
  print(result["data"])    -- response body
end
```

### Prepare a request without sending it

```lua
local fetchdef, err = client:prepare({
  path = "/api/resource/{id}",
  method = "DELETE",
  params = { id = "example" },
})
if err then error(err) end

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```lua
local client = sdk.test()

local result, err = client:Achievement():list()
-- result is the returned data; err is set on failure
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```lua
local function mock_fetch(url, init)
  return {
    status = 200,
    statusText = "OK",
    headers = {},
    json = function()
      return { id = "mock01" }
    end,
  }, nil
end

local client = sdk.new({
  base = "http://localhost:8080",
  system = {
    fetch = mock_fetch,
  },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
GUILD_WARS2_TEST_LIVE=TRUE
GUILD_WARS2_APIKEY=<your-key>
```

Then run:

```bash
cd lua && busted test/
```


## Reference

### GuildWars2SDK

```lua
local sdk = require("guild-wars2_sdk")
local client = sdk.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `table` | Feature activation flags. |
| `extend` | `table` | Additional Feature instances to load. |
| `system` | `table` | System overrides (e.g. custom `fetch` function). |

### test

```lua
local client = sdk.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### GuildWars2SDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> table` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> table, err` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs) -> table, err` | Build and send an HTTP request. |
| `Achievement` | `(data) -> AchievementEntity` | Create an Achievement entity instance. |
| `Authenticated` | `(data) -> AuthenticatedEntity` | Create an Authenticated entity instance. |
| `DailyReward` | `(data) -> DailyRewardEntity` | Create a DailyReward entity instance. |
| `GameMechanic` | `(data) -> GameMechanicEntity` | Create a GameMechanic entity instance. |
| `Guild` | `(data) -> GuildEntity` | Create a Guild entity instance. |
| `GuildAuthenticated` | `(data) -> GuildAuthenticatedEntity` | Create a GuildAuthenticated entity instance. |
| `HomeInstance` | `(data) -> HomeInstanceEntity` | Create a HomeInstance entity instance. |
| `Item` | `(data) -> ItemEntity` | Create an Item entity instance. |
| `Map` | `(data) -> MapEntity` | Create a Map entity instance. |
| `MapInformation` | `(data) -> MapInformationEntity` | Create a MapInformation entity instance. |
| `Miscellaneous` | `(data) -> MiscellaneousEntity` | Create a Miscellaneous entity instance. |
| `Story` | `(data) -> StoryEntity` | Create a Story entity instance. |
| `StructuredPvP` | `(data) -> StructuredPvPEntity` | Create a StructuredPvP entity instance. |
| `TradingPost` | `(data) -> TradingPostEntity` | Create a TradingPost entity instance. |
| `WorldVsWorld` | `(data) -> WorldVsWorldEntity` | Create a WorldVsWorld entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any, err` | Load a single entity by match criteria. |
| `list` | `(reqmatch, ctrl) -> any, err` | List entities matching the criteria. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(value, err)`. The `value` is the operation's
data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `load` | the entity record (a `table`) |
| `list` | an array (`table`) of entity records |

Check `err` first (it is non-`nil` on failure), then use `value`:

    local achievement, err = client:Achievement():load()
    if err then error(err) end
    -- achievement is the loaded record

Only `direct()` returns a response envelope — a `table` with `ok`,
`status`, `headers`, and `data` keys.

### Entities

#### Achievement

| Field | Description |
| --- | --- |

Operations: List, Load.

API path: `/achievements`

#### Authenticated

| Field | Description |
| --- | --- |
| `created` |  |
| `id` |  |
| `name` |  |
| `permission` |  |
| `subtoken` |  |
| `value` |  |
| `world` |  |

Operations: List, Load.

API path: `/characters`

#### DailyReward

| Field | Description |
| --- | --- |

Operations: List.

API path: `/dailycrafting`

#### GameMechanic

| Field | Description |
| --- | --- |

Operations: List.

API path: `/legendaryarmory`

#### Guild

| Field | Description |
| --- | --- |

Operations: List, Load.

API path: `/guild/permissions`

#### GuildAuthenticated

| Field | Description |
| --- | --- |

Operations: List.

API path: `/guild/{id}/log`

#### HomeInstance

| Field | Description |
| --- | --- |

Operations: List.

API path: `/home/cats`

#### Item

| Field | Description |
| --- | --- |

Operations: List.

API path: `/recipes/search`

#### Map

| Field | Description |
| --- | --- |

Operations: List.

API path: `/maps`

#### MapInformation

| Field | Description |
| --- | --- |

Operations: List.

API path: `/continents`

#### Miscellaneous

| Field | Description |
| --- | --- |
| `id` |  |

Operations: List, Load.

API path: `/colors`

#### Story

| Field | Description |
| --- | --- |

Operations: List.

API path: `/quests`

#### StructuredPvP

| Field | Description |
| --- | --- |

Operations: List.

API path: `/pvp/heroes`

#### TradingPost

| Field | Description |
| --- | --- |
| `coin` |  |
| `coins_per_gem` |  |
| `item` |  |
| `quantity` |  |

Operations: List, Load.

API path: `/commerce/listings`

#### WorldVsWorld

| Field | Description |
| --- | --- |

Operations: List.

API path: `/wvw/abilities`



## Entities


### Achievement

Create an instance: `local achievement = client:Achievement(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```lua
local achievement, err = client:Achievement():load()
```

#### Example: List

```lua
local achievements, err = client:Achievement():list()
```


### Authenticated

Create an instance: `local authenticated = client:Authenticated(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `permission` | `table` |  |
| `subtoken` | `string` |  |
| `value` | `number` |  |
| `world` | `number` |  |

#### Example: Load

```lua
local authenticated, err = client:Authenticated():load({ id = "authenticated_id" })
```

#### Example: List

```lua
local authenticateds, err = client:Authenticated():list()
```


### DailyReward

Create an instance: `local daily_reward = client:DailyReward(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local daily_rewards, err = client:DailyReward():list()
```


### GameMechanic

Create an instance: `local game_mechanic = client:GameMechanic(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local game_mechanics, err = client:GameMechanic():list()
```


### Guild

Create an instance: `local guild = client:Guild(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```lua
local guild, err = client:Guild():load({ id = "guild_id" })
```

#### Example: List

```lua
local guilds, err = client:Guild():list()
```


### GuildAuthenticated

Create an instance: `local guild_authenticated = client:GuildAuthenticated(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local guild_authenticateds, err = client:GuildAuthenticated():list()
```


### HomeInstance

Create an instance: `local home_instance = client:HomeInstance(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local home_instances, err = client:HomeInstance():list()
```


### Item

Create an instance: `local item = client:Item(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local items, err = client:Item():list()
```


### Map

Create an instance: `local map = client:Map(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local maps, err = client:Map():list()
```


### MapInformation

Create an instance: `local map_information = client:MapInformation(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local map_informations, err = client:MapInformation():list()
```


### Miscellaneous

Create an instance: `local miscellaneous = client:Miscellaneous(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `number` |  |

#### Example: Load

```lua
local miscellaneous, err = client:Miscellaneous():load({ id = 1 })
```

#### Example: List

```lua
local miscellaneouss, err = client:Miscellaneous():list()
```


### Story

Create an instance: `local story = client:Story(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local storys, err = client:Story():list()
```


### StructuredPvP

Create an instance: `local structured_pv_p = client:StructuredPvP(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local structured_pv_ps, err = client:StructuredPvP():list()
```


### TradingPost

Create an instance: `local trading_post = client:TradingPost(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `coin` | `number` |  |
| `coins_per_gem` | `number` |  |
| `item` | `table` |  |
| `quantity` | `number` |  |

#### Example: Load

```lua
local trading_post, err = client:TradingPost():load()
```

#### Example: List

```lua
local trading_posts, err = client:TradingPost():list()
```


### WorldVsWorld

Create an instance: `local world_vs_world = client:WorldVsWorld(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local world_vs_worlds, err = client:WorldVsWorld():list()
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is a Lua table
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as tables

The Lua SDK uses plain Lua tables throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a table.

### Module structure

```
lua/
├── guild-wars2_sdk.lua    -- Main SDK module
├── config.lua               -- Configuration
├── features.lua             -- Feature factory
├── core/                    -- Core types and context
├── entity/                  -- Entity implementations
├── feature/                 -- Built-in features (Base, Test, Log)
├── utility/                 -- Utility functions and struct library
└── test/                    -- Test suites
```

The main module (`guild-wars2_sdk`) exports the SDK constructor
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```lua
local achievement = client:Achievement()
achievement:list()

-- achievement:data_get() now returns the achievement data from the last list
-- achievement:match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
