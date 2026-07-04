# GuildWars2 Python SDK Reference

Complete API reference for the GuildWars2 Python SDK.


## GuildWars2SDK

### Constructor

```python
from guild-wars2_sdk import GuildWars2SDK

client = GuildWars2SDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `GuildWars2SDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = GuildWars2SDK.test()
```


### Instance Methods

#### `Achievement(data=None)`

Create a new `AchievementEntity` instance. Pass `None` for no initial data.

#### `Authenticated(data=None)`

Create a new `AuthenticatedEntity` instance. Pass `None` for no initial data.

#### `DailyReward(data=None)`

Create a new `DailyRewardEntity` instance. Pass `None` for no initial data.

#### `GameMechanic(data=None)`

Create a new `GameMechanicEntity` instance. Pass `None` for no initial data.

#### `Guild(data=None)`

Create a new `GuildEntity` instance. Pass `None` for no initial data.

#### `GuildAuthenticated(data=None)`

Create a new `GuildAuthenticatedEntity` instance. Pass `None` for no initial data.

#### `HomeInstance(data=None)`

Create a new `HomeInstanceEntity` instance. Pass `None` for no initial data.

#### `Item(data=None)`

Create a new `ItemEntity` instance. Pass `None` for no initial data.

#### `Map(data=None)`

Create a new `MapEntity` instance. Pass `None` for no initial data.

#### `MapInformation(data=None)`

Create a new `MapInformationEntity` instance. Pass `None` for no initial data.

#### `Miscellaneous(data=None)`

Create a new `MiscellaneousEntity` instance. Pass `None` for no initial data.

#### `Story(data=None)`

Create a new `StoryEntity` instance. Pass `None` for no initial data.

#### `StructuredPvP(data=None)`

Create a new `StructuredPvPEntity` instance. Pass `None` for no initial data.

#### `TradingPost(data=None)`

Create a new `TradingPostEntity` instance. Pass `None` for no initial data.

#### `WorldVsWorld(data=None)`

Create a new `WorldVsWorldEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## AchievementEntity

```python
achievement = client.Achievement()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Achievement().list({})
for achievement in results:
    print(achievement)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Achievement().load({"id": "achievement_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AchievementEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## AuthenticatedEntity

```python
authenticated = client.Authenticated()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |
| `permission` | ``$ARRAY`` | No |  |
| `subtoken` | ``$STRING`` | No |  |
| `value` | ``$INTEGER`` | No |  |
| `world` | ``$INTEGER`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Authenticated().list({})
for authenticated in results:
    print(authenticated)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Authenticated().load({"id": "authenticated_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AuthenticatedEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## DailyRewardEntity

```python
daily_reward = client.DailyReward()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.DailyReward().list({})
for daily_reward in results:
    print(daily_reward)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `DailyRewardEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## GameMechanicEntity

```python
game_mechanic = client.GameMechanic()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.GameMechanic().list({})
for game_mechanic in results:
    print(game_mechanic)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GameMechanicEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## GuildEntity

```python
guild = client.Guild()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Guild().list({})
for guild in results:
    print(guild)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Guild().load({"id": "guild_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GuildEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## GuildAuthenticatedEntity

```python
guild_authenticated = client.GuildAuthenticated()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.GuildAuthenticated().list({})
for guild_authenticated in results:
    print(guild_authenticated)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GuildAuthenticatedEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## HomeInstanceEntity

```python
home_instance = client.HomeInstance()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.HomeInstance().list({})
for home_instance in results:
    print(home_instance)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `HomeInstanceEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ItemEntity

```python
item = client.Item()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Item().list({})
for item in results:
    print(item)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ItemEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MapEntity

```python
map = client.Map()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Map().list({})
for map in results:
    print(map)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MapEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MapInformationEntity

```python
map_information = client.MapInformation()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.MapInformation().list({})
for map_information in results:
    print(map_information)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MapInformationEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MiscellaneousEntity

```python
miscellaneous = client.Miscellaneous()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Miscellaneous().list({})
for miscellaneous in results:
    print(miscellaneous)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Miscellaneous().load({"id": "miscellaneous_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MiscellaneousEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## StoryEntity

```python
story = client.Story()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Story().list({})
for story in results:
    print(story)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `StoryEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## StructuredPvPEntity

```python
structured_pv_p = client.StructuredPvP()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.StructuredPvP().list({})
for structured_pv_p in results:
    print(structured_pv_p)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `StructuredPvPEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TradingPostEntity

```python
trading_post = client.TradingPost()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coin` | ``$INTEGER`` | No |  |
| `coins_per_gem` | ``$INTEGER`` | No |  |
| `item` | ``$ARRAY`` | No |  |
| `quantity` | ``$INTEGER`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.TradingPost().list({})
for trading_post in results:
    print(trading_post)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.TradingPost().load({"id": "trading_post_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TradingPostEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## WorldVsWorldEntity

```python
world_vs_world = client.WorldVsWorld()
```

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.WorldVsWorld().list({})
for world_vs_world in results:
    print(world_vs_world)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `WorldVsWorldEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = GuildWars2SDK({
    "feature": {
        "test": {"active": True},
    },
})
```

