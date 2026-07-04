# GuildWars2 Golang SDK



The Golang SDK for the GuildWars2 API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/guild-wars2-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/guild-wars2-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/guild-wars2-sdk/go=../guild-wars2-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/guild-wars2-sdk/go"
)

func main() {
    client := sdk.NewGuildWars2SDK(map[string]any{
        "apikey": os.Getenv("GUILD_WARS2_APIKEY"),
    })

    // List achievement records — the value is the array of records itself.
    achievements, err := client.Achievement(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }
    for _, item := range achievements.([]any) {
        fmt.Println(item)
    }

    // Load a single achievement — the value is the loaded record.
    achievement, err := client.Achievement(nil).Load(map[string]any{"id": "example_id"}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(achievement)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

achievement, err := client.Achievement(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(achievement) // the loaded mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewGuildWars2SDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
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
cd go && go test ./test/...
```


## Reference

### NewGuildWars2SDK

```go
func NewGuildWars2SDK(options map[string]any) *GuildWars2SDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *GuildWars2SDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### GuildWars2SDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Achievement` | `(data map[string]any) GuildWars2Entity` | Create an Achievement entity instance. |
| `Authenticated` | `(data map[string]any) GuildWars2Entity` | Create an Authenticated entity instance. |
| `DailyReward` | `(data map[string]any) GuildWars2Entity` | Create a DailyReward entity instance. |
| `GameMechanic` | `(data map[string]any) GuildWars2Entity` | Create a GameMechanic entity instance. |
| `Guild` | `(data map[string]any) GuildWars2Entity` | Create a Guild entity instance. |
| `GuildAuthenticated` | `(data map[string]any) GuildWars2Entity` | Create a GuildAuthenticated entity instance. |
| `HomeInstance` | `(data map[string]any) GuildWars2Entity` | Create a HomeInstance entity instance. |
| `Item` | `(data map[string]any) GuildWars2Entity` | Create an Item entity instance. |
| `Map` | `(data map[string]any) GuildWars2Entity` | Create a Map entity instance. |
| `MapInformation` | `(data map[string]any) GuildWars2Entity` | Create a MapInformation entity instance. |
| `Miscellaneous` | `(data map[string]any) GuildWars2Entity` | Create a Miscellaneous entity instance. |
| `Story` | `(data map[string]any) GuildWars2Entity` | Create a Story entity instance. |
| `StructuredPvP` | `(data map[string]any) GuildWars2Entity` | Create a StructuredPvP entity instance. |
| `TradingPost` | `(data map[string]any) GuildWars2Entity` | Create a TradingPost entity instance. |
| `WorldVsWorld` | `(data map[string]any) GuildWars2Entity` | Create a WorldVsWorld entity instance. |

### Entity interface (GuildWars2Entity)

All entities implement the `GuildWars2Entity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Update` | `(reqdata, ctrl map[string]any) (any, error)` | Update an existing entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` / `Update` / `Remove` | the entity record (`map[string]any`) |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    achievement, err := client.Achievement(nil).Load(map[string]any{"id": "example_id"}, nil)
    if err != nil { /* handle */ }
    // achievement is the loaded record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Achievement

| Field | Description |
| --- | --- |

Operations: List, Load.

API path: `/achievements`

#### Authenticated

| Field | Description |
| --- | --- |
| `"created"` |  |
| `"id"` |  |
| `"name"` |  |
| `"permission"` |  |
| `"subtoken"` |  |
| `"value"` |  |
| `"world"` |  |

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
| `"id"` |  |

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
| `"coin"` |  |
| `"coins_per_gem"` |  |
| `"item"` |  |
| `"quantity"` |  |

Operations: List, Load.

API path: `/commerce/listings`

#### WorldVsWorld

| Field | Description |
| --- | --- |

Operations: List.

API path: `/wvw/abilities`



## Entities


### Achievement

Create an instance: `achievement := client.Achievement(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
achievement, err := client.Achievement(nil).Load(map[string]any{"id": "achievement_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(achievement) // the loaded record
```

#### Example: List

```go
achievements, err := client.Achievement(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(achievements) // the array of records
```


### Authenticated

Create an instance: `authenticated := client.Authenticated(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

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

```go
authenticated, err := client.Authenticated(nil).Load(map[string]any{"id": "authenticated_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(authenticated) // the loaded record
```

#### Example: List

```go
authenticateds, err := client.Authenticated(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(authenticateds) // the array of records
```


### DailyReward

Create an instance: `daily_reward := client.DailyReward(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
daily_rewards, err := client.DailyReward(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(daily_rewards) // the array of records
```


### GameMechanic

Create an instance: `game_mechanic := client.GameMechanic(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
game_mechanics, err := client.GameMechanic(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(game_mechanics) // the array of records
```


### Guild

Create an instance: `guild := client.Guild(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
guild, err := client.Guild(nil).Load(map[string]any{"id": "guild_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(guild) // the loaded record
```

#### Example: List

```go
guilds, err := client.Guild(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(guilds) // the array of records
```


### GuildAuthenticated

Create an instance: `guild_authenticated := client.GuildAuthenticated(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
guild_authenticateds, err := client.GuildAuthenticated(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(guild_authenticateds) // the array of records
```


### HomeInstance

Create an instance: `home_instance := client.HomeInstance(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
home_instances, err := client.HomeInstance(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(home_instances) // the array of records
```


### Item

Create an instance: `item := client.Item(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
items, err := client.Item(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(items) // the array of records
```


### Map

Create an instance: `map := client.Map(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
maps, err := client.Map(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(maps) // the array of records
```


### MapInformation

Create an instance: `map_information := client.MapInformation(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
map_informations, err := client.MapInformation(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(map_informations) // the array of records
```


### Miscellaneous

Create an instance: `miscellaneous := client.Miscellaneous(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$INTEGER`` |  |

#### Example: Load

```go
miscellaneous, err := client.Miscellaneous(nil).Load(map[string]any{"id": "miscellaneous_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(miscellaneous) // the loaded record
```

#### Example: List

```go
miscellaneouss, err := client.Miscellaneous(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(miscellaneouss) // the array of records
```


### Story

Create an instance: `story := client.Story(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
storys, err := client.Story(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(storys) // the array of records
```


### StructuredPvP

Create an instance: `structured_pv_p := client.StructuredPvP(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
structured_pv_ps, err := client.StructuredPvP(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(structured_pv_ps) // the array of records
```


### TradingPost

Create an instance: `trading_post := client.TradingPost(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `coin` | ``$INTEGER`` |  |
| `coins_per_gem` | ``$INTEGER`` |  |
| `item` | ``$ARRAY`` |  |
| `quantity` | ``$INTEGER`` |  |

#### Example: Load

```go
trading_post, err := client.TradingPost(nil).Load(map[string]any{"id": "trading_post_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(trading_post) // the loaded record
```

#### Example: List

```go
trading_posts, err := client.TradingPost(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(trading_posts) // the array of records
```


### WorldVsWorld

Create an instance: `world_vs_world := client.WorldVsWorld(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
world_vs_worlds, err := client.WorldVsWorld(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(world_vs_worlds) // the array of records
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
error is returned to the caller. An unexpected panic triggers the
`PreUnexpected` hook.

### Features and hooks

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/guild-wars2-sdk/go/
├── guild-wars2.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/guild-wars2-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
achievement := client.Achievement(nil)
achievement.Load(map[string]any{"id": "example_id"}, nil)

// achievement.Data() now returns the loaded achievement data
// achievement.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
