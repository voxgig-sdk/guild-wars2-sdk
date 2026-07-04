# GuildWars2 PHP SDK



The PHP SDK for the GuildWars2 API — an entity-oriented client using PHP conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Packagist. Install it from the
GitHub release tag (`php/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/guild-wars2-sdk/releases](https://github.com/voxgig-sdk/guild-wars2-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```php
<?php
require_once 'guildwars2_sdk.php';

$client = new GuildWars2SDK([
    "apikey" => getenv("GUILD_WARS2_APIKEY"),
]);
```

### 2. List achievements

```php
try {
    $result = $client->achievement()->list();
    if (is_array($result)) {
        foreach ($result as $item) {
            $d = $item->data_get();
            echo $d["id"] . " " . $d["name"] . "\n";
        }
    }
} catch (\Exception $err) {
    echo "Error: " . $err->getMessage();
}
```

### 3. Load an achievement

```php
try {
    $result = $client->achievement()->load(["id" => "example_id"]);
    print_r($result);
} catch (\Exception $err) {
    echo "Error: " . $err->getMessage();
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```php
// direct() is the raw-HTTP escape hatch: it returns a result array
// (it does not throw). Branch on $result["ok"].
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);

if ($result["ok"]) {
    echo $result["status"];  // 200
    print_r($result["data"]);  // response body
} else {
    echo "Error: " . $result["err"]->getMessage();
}
```

### Prepare a request without sending it

```php
// prepare() throws on error and returns the fetch definition.
$fetchdef = $client->prepare([
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => ["id" => "example"],
]);

echo $fetchdef["url"];
echo $fetchdef["method"];
print_r($fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required:

```php
$client = GuildWars2SDK::test();

$result = $client->achievement()->load(["id" => "test01"]);
// $result contains mock response data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```php
$mock_fetch = function ($url, $init) {
    return [
        [
            "status" => 200,
            "statusText" => "OK",
            "headers" => [],
            "json" => function () { return ["id" => "mock01"]; },
        ],
        null,
    ];
};

$client = new GuildWars2SDK([
    "base" => "http://localhost:8080",
    "system" => [
        "fetch" => $mock_fetch,
    ],
]);
```

### Run live tests

Create a `.env.local` file at the project root:

```
GUILD_WARS2_TEST_LIVE=TRUE
GUILD_WARS2_APIKEY=<your-key>
```

Then run:

```bash
cd php && ./vendor/bin/phpunit test/
```


## Reference

### GuildWars2SDK

```php
require_once 'guildwars2_sdk.php';
$client = new GuildWars2SDK($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `array` | Feature activation flags. |
| `extend` | `array` | Additional Feature instances to load. |
| `system` | `array` | System overrides (e.g. custom `fetch` callable). |

### test

```php
$client = GuildWars2SDK::test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### GuildWars2SDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `(): array` | Deep copy of current SDK options. |
| `get_utility` | `(): Utility` | Copy of the SDK utility object. |
| `prepare` | `(array $fetchargs): array` | Build an HTTP request definition without sending. |
| `direct` | `(array $fetchargs): array` | Build and send an HTTP request. |
| `Achievement` | `($data): AchievementEntity` | Create a Achievement entity instance. |
| `Authenticated` | `($data): AuthenticatedEntity` | Create a Authenticated entity instance. |
| `DailyReward` | `($data): DailyRewardEntity` | Create a DailyReward entity instance. |
| `GameMechanic` | `($data): GameMechanicEntity` | Create a GameMechanic entity instance. |
| `Guild` | `($data): GuildEntity` | Create a Guild entity instance. |
| `GuildAuthenticated` | `($data): GuildAuthenticatedEntity` | Create a GuildAuthenticated entity instance. |
| `HomeInstance` | `($data): HomeInstanceEntity` | Create a HomeInstance entity instance. |
| `Item` | `($data): ItemEntity` | Create a Item entity instance. |
| `Map` | `($data): MapEntity` | Create a Map entity instance. |
| `MapInformation` | `($data): MapInformationEntity` | Create a MapInformation entity instance. |
| `Miscellaneous` | `($data): MiscellaneousEntity` | Create a Miscellaneous entity instance. |
| `Story` | `($data): StoryEntity` | Create a Story entity instance. |
| `StructuredPvP` | `($data): StructuredPvPEntity` | Create a StructuredPvP entity instance. |
| `TradingPost` | `($data): TradingPostEntity` | Create a TradingPost entity instance. |
| `WorldVsWorld` | `($data): WorldVsWorldEntity` | Create a WorldVsWorld entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `($reqmatch, $ctrl): array` | Load a single entity by match criteria. |
| `list` | `($reqmatch, $ctrl): array` | List entities matching the criteria. |
| `create` | `($reqdata, $ctrl): array` | Create a new entity. |
| `update` | `($reqdata, $ctrl): array` | Update an existing entity. |
| `remove` | `($reqmatch, $ctrl): array` | Remove an entity. |
| `data_get` | `(): array` | Get entity data. |
| `data_set` | `($data): void` | Set entity data. |
| `match_get` | `(): array` | Get entity match criteria. |
| `match_set` | `($match): void` | Set entity match criteria. |
| `make` | `(): Entity` | Create a new instance with the same options. |
| `get_name` | `(): string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (an `array` for single-entity
ops, a `list` for `list`) and throw on error. Wrap calls in
`try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `array`
you branch on via `$result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `array` | Response headers. |
| `data` | `mixed` | Parsed JSON response body. |

On error, `ok` is `false` and `$err` contains the error value.

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
error is returned to the caller as the second element in the return array.

### Features and hooks

Features are the extension mechanism. A feature is a PHP class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as arrays

The PHP SDK uses plain PHP associative arrays throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers::to_map()` to safely validate that a value is an array.

### Directory structure

```
php/
├── guildwars2_sdk.php          -- Main SDK class
├── config.php                     -- Configuration
├── features.php                   -- Feature factory
├── core/                          -- Core types and context
├── entity/                        -- Entity implementations
├── feature/                       -- Built-in features (Base, Test, Log)
├── utility/                       -- Utility functions and struct library
└── test/                          -- Test suites
```

The main class (`guildwars2_sdk.php`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```php
$achievement = $client->achievement();
$achievement->load(["id" => "example_id"]);

// $achievement->dataGet() now returns the loaded achievement data
// $achievement->matchGet() returns the last match criteria
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
