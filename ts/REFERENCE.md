# GuildWars2 TypeScript SDK Reference

Complete API reference for the GuildWars2 TypeScript SDK.


## GuildWars2SDK

### Constructor

```ts
new GuildWars2SDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `GuildWars2SDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = GuildWars2SDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `GuildWars2SDK` instance in test mode.


### Instance Methods

#### `Achievement(data?: object)`

Create a new `Achievement` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `AchievementEntity` instance.

#### `Authenticated(data?: object)`

Create a new `Authenticated` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `AuthenticatedEntity` instance.

#### `DailyReward(data?: object)`

Create a new `DailyReward` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `DailyRewardEntity` instance.

#### `GameMechanic(data?: object)`

Create a new `GameMechanic` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `GameMechanicEntity` instance.

#### `Guild(data?: object)`

Create a new `Guild` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `GuildEntity` instance.

#### `GuildAuthenticated(data?: object)`

Create a new `GuildAuthenticated` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `GuildAuthenticatedEntity` instance.

#### `HomeInstance(data?: object)`

Create a new `HomeInstance` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `HomeInstanceEntity` instance.

#### `Item(data?: object)`

Create a new `Item` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ItemEntity` instance.

#### `Map(data?: object)`

Create a new `Map` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `MapEntity` instance.

#### `MapInformation(data?: object)`

Create a new `MapInformation` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `MapInformationEntity` instance.

#### `Miscellaneous(data?: object)`

Create a new `Miscellaneous` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `MiscellaneousEntity` instance.

#### `Story(data?: object)`

Create a new `Story` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `StoryEntity` instance.

#### `StructuredPvP(data?: object)`

Create a new `StructuredPvP` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `StructuredPvPEntity` instance.

#### `TradingPost(data?: object)`

Create a new `TradingPost` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `TradingPostEntity` instance.

#### `WorldVsWorld(data?: object)`

Create a new `WorldVsWorld` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `WorldVsWorldEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `GuildWars2SDK.test()`.

**Returns:** `GuildWars2SDK` instance in test mode.


---

## AchievementEntity

```ts
const achievement = client.achievement
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.achievement.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.achievement.load({ id: 'achievement_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `AchievementEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## AuthenticatedEntity

```ts
const authenticated = client.authenticated
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.authenticated.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.authenticated.load({ id: 'authenticated_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `AuthenticatedEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## DailyRewardEntity

```ts
const daily_reward = client.daily_reward
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.daily_reward.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `DailyRewardEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## GameMechanicEntity

```ts
const game_mechanic = client.game_mechanic
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.game_mechanic.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `GameMechanicEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## GuildEntity

```ts
const guild = client.guild
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.guild.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.guild.load({ id: 'guild_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `GuildEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## GuildAuthenticatedEntity

```ts
const guild_authenticated = client.guild_authenticated
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.guild_authenticated.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `GuildAuthenticatedEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## HomeInstanceEntity

```ts
const home_instance = client.home_instance
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.home_instance.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `HomeInstanceEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ItemEntity

```ts
const item = client.item
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.item.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ItemEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## MapEntity

```ts
const map = client.map
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.map.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `MapEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## MapInformationEntity

```ts
const map_information = client.map_information
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.map_information.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `MapInformationEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## MiscellaneousEntity

```ts
const miscellaneous = client.miscellaneous
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.miscellaneous.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.miscellaneous.load({ id: 'miscellaneous_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `MiscellaneousEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## StoryEntity

```ts
const story = client.story
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.story.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `StoryEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## StructuredPvPEntity

```ts
const structured_pv_p = client.structured_pv_p
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.structured_pv_p.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `StructuredPvPEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## TradingPostEntity

```ts
const trading_post = client.trading_post
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coin` | ``$INTEGER`` | No |  |
| `coins_per_gem` | ``$INTEGER`` | No |  |
| `item` | ``$ARRAY`` | No |  |
| `quantity` | ``$INTEGER`` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.trading_post.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.trading_post.load({ id: 'trading_post_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `TradingPostEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## WorldVsWorldEntity

```ts
const world_vs_world = client.world_vs_world
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.world_vs_world.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `WorldVsWorldEntity` instance with the same client and
options.

#### `client()`

Return the parent `GuildWars2SDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new GuildWars2SDK({
  feature: {
    test: { active: true },
  }
})
```

