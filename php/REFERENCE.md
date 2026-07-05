# GuildWars2 PHP SDK Reference

Complete API reference for the GuildWars2 PHP SDK.


## GuildWars2SDK

### Constructor

```php
require_once __DIR__ . '/guildwars2_sdk.php';

$client = new GuildWars2SDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `GuildWars2SDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = GuildWars2SDK::test();
```


### Instance Methods

#### `Achievement($data = null)`

Create a new `AchievementEntity` instance. Pass `null` for no initial data.

#### `Authenticated($data = null)`

Create a new `AuthenticatedEntity` instance. Pass `null` for no initial data.

#### `DailyReward($data = null)`

Create a new `DailyRewardEntity` instance. Pass `null` for no initial data.

#### `GameMechanic($data = null)`

Create a new `GameMechanicEntity` instance. Pass `null` for no initial data.

#### `Guild($data = null)`

Create a new `GuildEntity` instance. Pass `null` for no initial data.

#### `GuildAuthenticated($data = null)`

Create a new `GuildAuthenticatedEntity` instance. Pass `null` for no initial data.

#### `HomeInstance($data = null)`

Create a new `HomeInstanceEntity` instance. Pass `null` for no initial data.

#### `Item($data = null)`

Create a new `ItemEntity` instance. Pass `null` for no initial data.

#### `Map($data = null)`

Create a new `MapEntity` instance. Pass `null` for no initial data.

#### `MapInformation($data = null)`

Create a new `MapInformationEntity` instance. Pass `null` for no initial data.

#### `Miscellaneous($data = null)`

Create a new `MiscellaneousEntity` instance. Pass `null` for no initial data.

#### `Story($data = null)`

Create a new `StoryEntity` instance. Pass `null` for no initial data.

#### `StructuredPvP($data = null)`

Create a new `StructuredPvPEntity` instance. Pass `null` for no initial data.

#### `TradingPost($data = null)`

Create a new `TradingPostEntity` instance. Pass `null` for no initial data.

#### `WorldVsWorld($data = null)`

Create a new `WorldVsWorldEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): GuildWars2Utility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## AchievementEntity

```php
$achievement = $client->Achievement();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Achievement()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Achievement()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): AchievementEntity`

Create a new `AchievementEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## AuthenticatedEntity

```php
$authenticated = $client->Authenticated();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created` | `string` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `permission` | `array` | No |  |
| `subtoken` | `string` | No |  |
| `value` | `int` | No |  |
| `world` | `int` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Authenticated()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Authenticated()->load(["id" => "authenticated_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): AuthenticatedEntity`

Create a new `AuthenticatedEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## DailyRewardEntity

```php
$daily_reward = $client->DailyReward();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->DailyReward()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): DailyRewardEntity`

Create a new `DailyRewardEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## GameMechanicEntity

```php
$game_mechanic = $client->GameMechanic();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->GameMechanic()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): GameMechanicEntity`

Create a new `GameMechanicEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## GuildEntity

```php
$guild = $client->Guild();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Guild()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Guild()->load(["id" => "guild_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): GuildEntity`

Create a new `GuildEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## GuildAuthenticatedEntity

```php
$guild_authenticated = $client->GuildAuthenticated();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->GuildAuthenticated()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): GuildAuthenticatedEntity`

Create a new `GuildAuthenticatedEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## HomeInstanceEntity

```php
$home_instance = $client->HomeInstance();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->HomeInstance()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): HomeInstanceEntity`

Create a new `HomeInstanceEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ItemEntity

```php
$item = $client->Item();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Item()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ItemEntity`

Create a new `ItemEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## MapEntity

```php
$map = $client->Map();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Map()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): MapEntity`

Create a new `MapEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## MapInformationEntity

```php
$map_information = $client->MapInformation();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->MapInformation()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): MapInformationEntity`

Create a new `MapInformationEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## MiscellaneousEntity

```php
$miscellaneous = $client->Miscellaneous();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `int` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Miscellaneous()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Miscellaneous()->load(["id" => "miscellaneous_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): MiscellaneousEntity`

Create a new `MiscellaneousEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## StoryEntity

```php
$story = $client->Story();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Story()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): StoryEntity`

Create a new `StoryEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## StructuredPvPEntity

```php
$structured_pv_p = $client->StructuredPvP();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->StructuredPvP()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): StructuredPvPEntity`

Create a new `StructuredPvPEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## TradingPostEntity

```php
$trading_post = $client->TradingPost();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coin` | `int` | No |  |
| `coins_per_gem` | `int` | No |  |
| `item` | `array` | No |  |
| `quantity` | `int` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->TradingPost()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->TradingPost()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): TradingPostEntity`

Create a new `TradingPostEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## WorldVsWorldEntity

```php
$world_vs_world = $client->WorldVsWorld();
```

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->WorldVsWorld()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): WorldVsWorldEntity`

Create a new `WorldVsWorldEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new GuildWars2SDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

