# GuildWars2 Python SDK



The Python SDK for the GuildWars2 API — an entity-oriented client following Pythonic conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Achievement()` — each
carrying a small, uniform set of operations (`list`, `load`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

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

### 2. List achievement records

`list()` returns a `list` of records (each a `dict`) and raises on
error — iterate it directly.

```python
try:
    achievements = client.Achievement().list()
    for achievement in achievements:
        print(achievement)
except Exception as err:
    print(f"list failed: {err}")
```

### 3. Load an achievement

`load()` returns the bare record (a `dict`) and raises on error.

```python
try:
    achievement = client.Achievement().load()
    print(achievement)
except Exception as err:
    print(f"load failed: {err}")
```


## Error handling

Entity operations raise on failure, so wrap them in `try` / `except`:

```python
try:
    achievements = client.Achievement().list()
    print(achievements)
except Exception as err:
    print(f"list failed: {err}")
```

`direct()` does **not** raise — it returns the result envelope. Branch
on `ok`; on failure `status` holds the HTTP status (for error responses)
and `err` holds a transport error, so read both defensively:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example_id"},
})

if not result["ok"]:
    print("request failed:", result.get("status"), result.get("err"))
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
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read both with .get() rather than indexing a key that may be absent.
    print(result.get("status"), result.get("err"))
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

# Entity ops return the bare record and raise on error.
achievement = client.Achievement().list()
# achievement contains the mock response record
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
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria. Raises on error. |
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

Create an instance: `achievement = client.Achievement()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
achievement = client.Achievement().load()
```

#### Example: List

```python
achievements = client.Achievement().list()
```


### Authenticated

Create an instance: `authenticated = client.Authenticated()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created` | `str` |  |
| `id` | `str` |  |
| `name` | `str` |  |
| `permission` | `list` |  |
| `subtoken` | `str` |  |
| `value` | `int` |  |
| `world` | `int` |  |

#### Example: Load

```python
authenticated = client.Authenticated().load({"id": "authenticated_id"})
```

#### Example: List

```python
authenticateds = client.Authenticated().list()
```


### DailyReward

Create an instance: `daily_reward = client.DailyReward()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
daily_rewards = client.DailyReward().list()
```


### GameMechanic

Create an instance: `game_mechanic = client.GameMechanic()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
game_mechanics = client.GameMechanic().list()
```


### Guild

Create an instance: `guild = client.Guild()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
guild = client.Guild().load({"id": "guild_id"})
```

#### Example: List

```python
guilds = client.Guild().list()
```


### GuildAuthenticated

Create an instance: `guild_authenticated = client.GuildAuthenticated()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
guild_authenticateds = client.GuildAuthenticated().list()
```


### HomeInstance

Create an instance: `home_instance = client.HomeInstance()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
home_instances = client.HomeInstance().list()
```


### Item

Create an instance: `item = client.Item()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
items = client.Item().list()
```


### Map

Create an instance: `map = client.Map()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
maps = client.Map().list()
```


### MapInformation

Create an instance: `map_information = client.MapInformation()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
map_informations = client.MapInformation().list()
```


### Miscellaneous

Create an instance: `miscellaneous = client.Miscellaneous()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `int` |  |

#### Example: Load

```python
miscellaneous = client.Miscellaneous().load({"id": "miscellaneous_id"})
```

#### Example: List

```python
miscellaneouss = client.Miscellaneous().list()
```


### Story

Create an instance: `story = client.Story()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
storys = client.Story().list()
```


### StructuredPvP

Create an instance: `structured_pv_p = client.StructuredPvP()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
structured_pv_ps = client.StructuredPvP().list()
```


### TradingPost

Create an instance: `trading_post = client.TradingPost()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `coin` | `int` |  |
| `coins_per_gem` | `int` |  |
| `item` | `list` |  |
| `quantity` | `int` |  |

#### Example: Load

```python
trading_post = client.TradingPost().load()
```

#### Example: List

```python
trading_posts = client.TradingPost().list()
```


### WorldVsWorld

Create an instance: `world_vs_world = client.WorldVsWorld()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Example: List

```python
world_vs_worlds = client.WorldVsWorld().list()
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

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```python
achievement = client.Achievement()
achievement.list()

# achievement.data_get() now returns the achievement data from the last list
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
