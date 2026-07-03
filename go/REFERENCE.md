# GuildWars2 Golang SDK Reference

Complete API reference for the GuildWars2 Golang SDK.


## GuildWars2SDK

### Constructor

```go
func NewGuildWars2SDK(options map[string]any) *GuildWars2SDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *GuildWars2SDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *GuildWars2SDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Achievement(data map[string]any) GuildWars2Entity`

Create a new `Achievement` entity instance. Pass `nil` for no initial data.

#### `Authenticated(data map[string]any) GuildWars2Entity`

Create a new `Authenticated` entity instance. Pass `nil` for no initial data.

#### `DailyReward(data map[string]any) GuildWars2Entity`

Create a new `DailyReward` entity instance. Pass `nil` for no initial data.

#### `GameMechanic(data map[string]any) GuildWars2Entity`

Create a new `GameMechanic` entity instance. Pass `nil` for no initial data.

#### `Guild(data map[string]any) GuildWars2Entity`

Create a new `Guild` entity instance. Pass `nil` for no initial data.

#### `GuildAuthenticated(data map[string]any) GuildWars2Entity`

Create a new `GuildAuthenticated` entity instance. Pass `nil` for no initial data.

#### `HomeInstance(data map[string]any) GuildWars2Entity`

Create a new `HomeInstance` entity instance. Pass `nil` for no initial data.

#### `Item(data map[string]any) GuildWars2Entity`

Create a new `Item` entity instance. Pass `nil` for no initial data.

#### `Map(data map[string]any) GuildWars2Entity`

Create a new `Map` entity instance. Pass `nil` for no initial data.

#### `MapInformation(data map[string]any) GuildWars2Entity`

Create a new `MapInformation` entity instance. Pass `nil` for no initial data.

#### `Miscellaneous(data map[string]any) GuildWars2Entity`

Create a new `Miscellaneous` entity instance. Pass `nil` for no initial data.

#### `Story(data map[string]any) GuildWars2Entity`

Create a new `Story` entity instance. Pass `nil` for no initial data.

#### `StructuredPvP(data map[string]any) GuildWars2Entity`

Create a new `StructuredPvP` entity instance. Pass `nil` for no initial data.

#### `TradingPost(data map[string]any) GuildWars2Entity`

Create a new `TradingPost` entity instance. Pass `nil` for no initial data.

#### `WorldVsWorld(data map[string]any) GuildWars2Entity`

Create a new `WorldVsWorld` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## AchievementEntity

```go
achievement := client.Achievement(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Achievement(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Achievement(nil).Load(map[string]any{"id": "achievement_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `AchievementEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## AuthenticatedEntity

```go
authenticated := client.Authenticated(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Authenticated(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Authenticated(nil).Load(map[string]any{"id": "authenticated_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `AuthenticatedEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## DailyRewardEntity

```go
daily_reward := client.DailyReward(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.DailyReward(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `DailyRewardEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## GameMechanicEntity

```go
game_mechanic := client.GameMechanic(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.GameMechanic(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `GameMechanicEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## GuildEntity

```go
guild := client.Guild(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Guild(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Guild(nil).Load(map[string]any{"id": "guild_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `GuildEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## GuildAuthenticatedEntity

```go
guild_authenticated := client.GuildAuthenticated(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.GuildAuthenticated(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `GuildAuthenticatedEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## HomeInstanceEntity

```go
home_instance := client.HomeInstance(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.HomeInstance(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `HomeInstanceEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ItemEntity

```go
item := client.Item(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Item(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ItemEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## MapEntity

```go
map := client.Map(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Map(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MapEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## MapInformationEntity

```go
map_information := client.MapInformation(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.MapInformation(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MapInformationEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## MiscellaneousEntity

```go
miscellaneous := client.Miscellaneous(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Miscellaneous(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Miscellaneous(nil).Load(map[string]any{"id": "miscellaneous_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MiscellaneousEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## StoryEntity

```go
story := client.Story(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Story(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `StoryEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## StructuredPvPEntity

```go
structured_pv_p := client.StructuredPvP(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.StructuredPvP(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `StructuredPvPEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## TradingPostEntity

```go
trading_post := client.TradingPost(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coin` | ``$INTEGER`` | No |  |
| `coins_per_gem` | ``$INTEGER`` | No |  |
| `item` | ``$ARRAY`` | No |  |
| `quantity` | ``$INTEGER`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.TradingPost(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.TradingPost(nil).Load(map[string]any{"id": "trading_post_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `TradingPostEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## WorldVsWorldEntity

```go
world_vs_world := client.WorldVsWorld(nil)
```

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.WorldVsWorld(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `WorldVsWorldEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewGuildWars2SDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

