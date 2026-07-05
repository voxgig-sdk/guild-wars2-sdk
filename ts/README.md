# GuildWars2 TypeScript SDK



The TypeScript SDK for the GuildWars2 API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Achievement()` — each with a small set of operations (`list`, `load`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/guild-wars2-sdk/releases](https://github.com/voxgig-sdk/guild-wars2-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { GuildWars2SDK } from '@voxgig-sdk/guild-wars2'

const client = new GuildWars2SDK({
  apikey: process.env.GUILD_WARS2_APIKEY,
})
```

### 2. List achievement records

`list()` resolves to an array of Achievement objects — iterate it directly:

```ts
const achievements = await client.Achievement().list()

for (const achievement of achievements) {
  console.log(achievement)
}
```

### 3. Load an achievement

`load()` returns the entity directly and throws on failure:

```ts
try {
  const achievement = await client.Achievement().load()
  console.log(achievement)
} catch (err) {
  console.error('load failed:', err)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const achievements = await client.Achievement().list()
  console.log(achievements)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result instanceof Error) {
  throw result
}
if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = GuildWars2SDK.test()

const achievement = await client.Achievement().list()
// achievement is a bare entity populated with mock response data
console.log(achievement)
```

You can also use the instance method:

```ts
const client = new GuildWars2SDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Achievement()

// First call runs the operation and stores its result
await entity.list()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new GuildWars2SDK({
  apikey: '...',
  extend: [logger],
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
cd ts && npm test
```


## Reference

### GuildWars2SDK

#### Constructor

```ts
new GuildWars2SDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Achievement(data?)` | `AchievementEntity` | Create an Achievement entity instance. |
| `Authenticated(data?)` | `AuthenticatedEntity` | Create an Authenticated entity instance. |
| `DailyReward(data?)` | `DailyRewardEntity` | Create a DailyReward entity instance. |
| `GameMechanic(data?)` | `GameMechanicEntity` | Create a GameMechanic entity instance. |
| `Guild(data?)` | `GuildEntity` | Create a Guild entity instance. |
| `GuildAuthenticated(data?)` | `GuildAuthenticatedEntity` | Create a GuildAuthenticated entity instance. |
| `HomeInstance(data?)` | `HomeInstanceEntity` | Create a HomeInstance entity instance. |
| `Item(data?)` | `ItemEntity` | Create an Item entity instance. |
| `Map(data?)` | `MapEntity` | Create a Map entity instance. |
| `MapInformation(data?)` | `MapInformationEntity` | Create a MapInformation entity instance. |
| `Miscellaneous(data?)` | `MiscellaneousEntity` | Create a Miscellaneous entity instance. |
| `Story(data?)` | `StoryEntity` | Create a Story entity instance. |
| `StructuredPvP(data?)` | `StructuredPvPEntity` | Create a StructuredPvP entity instance. |
| `TradingPost(data?)` | `TradingPostEntity` | Create a TradingPost entity instance. |
| `WorldVsWorld(data?)` | `WorldVsWorldEntity` | Create a WorldVsWorld entity instance. |
| `tester(testopts?, sdkopts?)` | `GuildWars2SDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `GuildWars2SDK.test(testopts?, sdkopts?)` | `GuildWars2SDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): GuildWars2SDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load` resolves to a single entity object.
- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

### Entities

#### Achievement

| Field | Description |
| --- | --- |

Operations: list, load.

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

Operations: list, load.

API path: `/characters`

#### DailyReward

| Field | Description |
| --- | --- |

Operations: list.

API path: `/dailycrafting`

#### GameMechanic

| Field | Description |
| --- | --- |

Operations: list.

API path: `/legendaryarmory`

#### Guild

| Field | Description |
| --- | --- |

Operations: list, load.

API path: `/guild/permissions`

#### GuildAuthenticated

| Field | Description |
| --- | --- |

Operations: list.

API path: `/guild/{id}/log`

#### HomeInstance

| Field | Description |
| --- | --- |

Operations: list.

API path: `/home/cats`

#### Item

| Field | Description |
| --- | --- |

Operations: list.

API path: `/recipes/search`

#### Map

| Field | Description |
| --- | --- |

Operations: list.

API path: `/maps`

#### MapInformation

| Field | Description |
| --- | --- |

Operations: list.

API path: `/continents`

#### Miscellaneous

| Field | Description |
| --- | --- |
| `id` |  |

Operations: list, load.

API path: `/colors`

#### Story

| Field | Description |
| --- | --- |

Operations: list.

API path: `/quests`

#### StructuredPvP

| Field | Description |
| --- | --- |

Operations: list.

API path: `/pvp/heroes`

#### TradingPost

| Field | Description |
| --- | --- |
| `coin` |  |
| `coins_per_gem` |  |
| `item` |  |
| `quantity` |  |

Operations: list, load.

API path: `/commerce/listings`

#### WorldVsWorld

| Field | Description |
| --- | --- |

Operations: list.

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
const achievement = await client.Achievement().load()
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
| `created` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `permission` | `any[]` |  |
| `subtoken` | `string` |  |
| `value` | `number` |  |
| `world` | `number` |  |

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
| `id` | `number` |  |

#### Example: Load

```ts
const miscellaneous = await client.Miscellaneous().load({ id: 1 })
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
| `coin` | `number` |  |
| `coins_per_gem` | `number` |  |
| `item` | `any[]` |  |
| `quantity` | `number` |  |

#### Example: Load

```ts
const trading_post = await client.TradingPost().load()
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

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
guild-wars2/
├── src/
│   ├── GuildWars2SDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { GuildWars2SDK } from '@voxgig-sdk/guild-wars2'
```

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const achievement = client.Achievement()
await achievement.list()

// achievement.data() now returns the achievement data from the last `list`
// achievement.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
