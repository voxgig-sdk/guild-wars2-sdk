# GuildWars2 Lua SDK



The Lua SDK for the GuildWars2 API — an entity-oriented client using Lua conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```bash
luarocks install voxgig-sdk-guild-wars2
```

If the module is not yet published, add the source directory to
your `LUA_PATH`:

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
  apikey = os.getenv("GUILD-WARS2_APIKEY"),
})
```

### 2. List achievements

```lua
local result, err = client:Achievement():list()
if err then error(err) end

if type(result) == "table" then
  for _, item in ipairs(result) do
    local d = item:data_get()
    print(d["id"], d["name"])
  end
end
```

### 3. Load a achievement

```lua
local result, err = client:Achievement():load({ id = "example_id" })
if err then error(err) end
print(result)
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

local result, err = client:GuildWars2():load({ id = "test01" })
-- result contains mock response data
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
GUILD-WARS2_TEST_LIVE=TRUE
GUILD-WARS2_APIKEY=<your-key>
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
| `Achievement` | `(data) -> AchievementEntity` | Create a Achievement entity instance. |
| `Authenticated` | `(data) -> AuthenticatedEntity` | Create a Authenticated entity instance. |
| `DailyReward` | `(data) -> DailyRewardEntity` | Create a DailyReward entity instance. |
| `GameMechanic` | `(data) -> GameMechanicEntity` | Create a GameMechanic entity instance. |
| `Guild` | `(data) -> GuildEntity` | Create a Guild entity instance. |
| `GuildAuthenticated` | `(data) -> GuildAuthenticatedEntity` | Create a GuildAuthenticated entity instance. |
| `HomeInstance` | `(data) -> HomeInstanceEntity` | Create a HomeInstance entity instance. |
| `Item` | `(data) -> ItemEntity` | Create a Item entity instance. |
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
| `create` | `(reqdata, ctrl) -> any, err` | Create a new entity. |
| `update` | `(reqdata, ctrl) -> any, err` | Update an existing entity. |
| `remove` | `(reqmatch, ctrl) -> any, err` | Remove an entity. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(any, err)`. The first value is a
`table` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `table` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

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

Create an instance: `const achievement = client.Achievement()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const achievement = await client.Achievement().load({ id: 'achievement_id' })
```

#### Example: List

```ts
const achievements = await client.Achievement().list()
```


### Authenticated

Create an instance: `const authenticated = client.Authenticated()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |
| `permission` | ``$ARRAY`` |  |
| `subtoken` | ``$STRING`` |  |
| `value` | ``$INTEGER`` |  |
| `world` | ``$INTEGER`` |  |

#### Example: Load

```ts
const authenticated = await client.Authenticated().load({ id: 'authenticated_id' })
```

#### Example: List

```ts
const authenticateds = await client.Authenticated().list()
```


### DailyReward

Create an instance: `const daily_reward = client.DailyReward()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const daily_rewards = await client.DailyReward().list()
```


### GameMechanic

Create an instance: `const game_mechanic = client.GameMechanic()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const game_mechanics = await client.GameMechanic().list()
```


### Guild

Create an instance: `const guild = client.Guild()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const guild = await client.Guild().load({ id: 'guild_id' })
```

#### Example: List

```ts
const guilds = await client.Guild().list()
```


### GuildAuthenticated

Create an instance: `const guild_authenticated = client.GuildAuthenticated()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const guild_authenticateds = await client.GuildAuthenticated().list()
```


### HomeInstance

Create an instance: `const home_instance = client.HomeInstance()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const home_instances = await client.HomeInstance().list()
```


### Item

Create an instance: `const item = client.Item()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const items = await client.Item().list()
```


### Map

Create an instance: `const map = client.Map()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const maps = await client.Map().list()
```


### MapInformation

Create an instance: `const map_information = client.MapInformation()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const map_informations = await client.MapInformation().list()
```


### Miscellaneous

Create an instance: `const miscellaneous = client.Miscellaneous()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$INTEGER`` |  |

#### Example: Load

```ts
const miscellaneous = await client.Miscellaneous().load({ id: 'miscellaneous_id' })
```

#### Example: List

```ts
const miscellaneouss = await client.Miscellaneous().list()
```


### Story

Create an instance: `const story = client.Story()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const storys = await client.Story().list()
```


### StructuredPvP

Create an instance: `const structured_pv_p = client.StructuredPvP()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const structured_pv_ps = await client.StructuredPvP().list()
```


### TradingPost

Create an instance: `const trading_post = client.TradingPost()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `coin` | ``$INTEGER`` |  |
| `coins_per_gem` | ``$INTEGER`` |  |
| `item` | ``$ARRAY`` |  |
| `quantity` | ``$INTEGER`` |  |

#### Example: Load

```ts
const trading_post = await client.TradingPost().load({ id: 'trading_post_id' })
```

#### Example: List

```ts
const trading_posts = await client.TradingPost().list()
```


### WorldVsWorld

Create an instance: `const world_vs_world = client.WorldVsWorld()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const world_vs_worlds = await client.WorldVsWorld().list()
```


## Explanation

### The operation pipeline

Every entity operation (load, list, create, update, remove) follows a
six-stage pipeline. Each stage fires a feature hook before executing:

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

If any stage returns an error, the pipeline short-circuits and the
error is returned to the caller as a second return value.

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

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```lua
local moon = client:Moon(nil)
moon:load({ planet_id = "earth", id = "luna" }, nil)

-- moon:data_get() now returns the loaded moon data
-- moon:match_get() returns the last match criteria
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
