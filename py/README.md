# GuildWars2 Python SDK



The Python SDK for the GuildWars2 API — an entity-oriented client following Pythonic conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/guild-wars2-sdk/releases)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```python
import os
from guildwars2_sdk import GuildWars2SDK

client = GuildWars2SDK({
    "apikey": os.environ.get("GUILD_WARS2_APIKEY"),
})
```

### 2. List achievements

```python
try:
    result = client.achievement.list()
    for item in result:
        d = item.data_get()
        print(d["id"], d["name"])
except Exception as err:
    print(f"list failed: {err}")
```

### 3. Load an achievement

```python
try:
    result = client.achievement.load({"id": "example_id"})
    print(result)
except Exception as err:
    print(f"load failed: {err}")
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    print(result["err"])     # error value
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = GuildWars2SDK.test()

result = client.achievement.load({"id": "test01"})
# result contains mock response data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = GuildWars2SDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
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
cd py && pytest test/
```


## Reference

### GuildWars2SDK

```python
from guildwars2_sdk import GuildWars2SDK

client = GuildWars2SDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `str` | API key for authentication. |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = GuildWars2SDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### GuildWars2SDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
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
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `update` | `(reqdata, ctrl) -> any` | Update an existing entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `dict` for single-entity
ops, a `list` for `list`) and raise on error. Wrap calls in
`try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `const achievement = client.achievement`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const achievement = await client.achievement.load({ id: 'achievement_id' })
```

#### Example: List

```ts
const achievements = await client.achievement.list()
```


### Authenticated

Create an instance: `const authenticated = client.authenticated`

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
const authenticated = await client.authenticated.load({ id: 'authenticated_id' })
```

#### Example: List

```ts
const authenticateds = await client.authenticated.list()
```


### DailyReward

Create an instance: `const daily_reward = client.daily_reward`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const daily_rewards = await client.daily_reward.list()
```


### GameMechanic

Create an instance: `const game_mechanic = client.game_mechanic`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const game_mechanics = await client.game_mechanic.list()
```


### Guild

Create an instance: `const guild = client.guild`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const guild = await client.guild.load({ id: 'guild_id' })
```

#### Example: List

```ts
const guilds = await client.guild.list()
```


### GuildAuthenticated

Create an instance: `const guild_authenticated = client.guild_authenticated`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const guild_authenticateds = await client.guild_authenticated.list()
```


### HomeInstance

Create an instance: `const home_instance = client.home_instance`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const home_instances = await client.home_instance.list()
```


### Item

Create an instance: `const item = client.item`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const items = await client.item.list()
```


### Map

Create an instance: `const map = client.map`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const maps = await client.map.list()
```


### MapInformation

Create an instance: `const map_information = client.map_information`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const map_informations = await client.map_information.list()
```


### Miscellaneous

Create an instance: `const miscellaneous = client.miscellaneous`

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
const miscellaneous = await client.miscellaneous.load({ id: 'miscellaneous_id' })
```

#### Example: List

```ts
const miscellaneouss = await client.miscellaneous.list()
```


### Story

Create an instance: `const story = client.story`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const storys = await client.story.list()
```


### StructuredPvP

Create an instance: `const structured_pv_p = client.structured_pv_p`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const structured_pv_ps = await client.structured_pv_p.list()
```


### TradingPost

Create an instance: `const trading_post = client.trading_post`

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
const trading_post = await client.trading_post.load({ id: 'trading_post_id' })
```

#### Example: List

```ts
const trading_posts = await client.trading_post.list()
```


### WorldVsWorld

Create an instance: `const world_vs_world = client.world_vs_world`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ts
const world_vs_worlds = await client.world_vs_world.list()
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
error is returned to the caller as the second element in the return tuple.

### Features and hooks

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── guildwars2_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`guildwars2_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```python
achievement = client.achievement
achievement.load({"id": "example_id"})

# achievement.data_get() now returns the loaded achievement data
# achievement.match_get() returns the last match criteria
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
