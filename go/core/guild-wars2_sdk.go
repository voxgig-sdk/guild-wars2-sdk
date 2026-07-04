package core

import (
	"fmt"

	vs "github.com/voxgig-sdk/guild-wars2-sdk/go/utility/struct"
)

type GuildWars2SDK struct {
	Mode     string
	options  map[string]any
	utility  *Utility
	Features []Feature
	rootctx  *Context
}

func NewGuildWars2SDK(options map[string]any) *GuildWars2SDK {
	sdk := &GuildWars2SDK{
		Mode:     "live",
		Features: []Feature{},
	}

	sdk.utility = NewUtility()

	config := MakeConfig()

	sdk.rootctx = sdk.utility.MakeContext(map[string]any{
		"client":  sdk,
		"utility": sdk.utility,
		"config":  config,
		"options": options,
		"shared":  map[string]any{},
	}, nil)

	sdk.options = sdk.utility.MakeOptions(sdk.rootctx)

	if vs.GetPath([]any{"feature", "test", "active"}, sdk.options) == true {
		sdk.Mode = "test"
	}

	sdk.rootctx.Options = sdk.options

	// Add features from config.
	featureOpts := ToMapAny(vs.GetProp(sdk.options, "feature"))
	if featureOpts != nil {
		for _, item := range vs.Items(featureOpts) {
			fname, _ := item[0].(string)
			fopts := ToMapAny(item[1])
			if fopts != nil {
				if active, ok := fopts["active"]; ok {
					if ab, ok := active.(bool); ok && ab {
						sdk.utility.FeatureAdd(sdk.rootctx, makeFeature(fname))
					}
				}
			}
		}
	}

	// Add extension features.
	if extend := vs.GetProp(sdk.options, "extend"); extend != nil {
		if extList, ok := extend.([]any); ok {
			for _, f := range extList {
				if feat, ok := f.(Feature); ok {
					sdk.utility.FeatureAdd(sdk.rootctx, feat)
				}
			}
		}
	}

	// Initialize features.
	for _, f := range sdk.Features {
		sdk.utility.FeatureInit(sdk.rootctx, f)
	}

	sdk.utility.FeatureHook(sdk.rootctx, "PostConstruct")

	return sdk
}

func (sdk *GuildWars2SDK) OptionsMap() map[string]any {
	out := vs.Clone(sdk.options)
	if om, ok := out.(map[string]any); ok {
		return om
	}
	return map[string]any{}
}

func (sdk *GuildWars2SDK) GetUtility() *Utility {
	return CopyUtility(sdk.utility)
}

func (sdk *GuildWars2SDK) GetRootCtx() *Context {
	return sdk.rootctx
}

func (sdk *GuildWars2SDK) Prepare(fetchargs map[string]any) (map[string]any, error) {
	utility := sdk.utility

	if fetchargs == nil {
		fetchargs = map[string]any{}
	}

	var ctrl map[string]any
	if c := vs.GetProp(fetchargs, "ctrl"); c != nil {
		if cm, ok := c.(map[string]any); ok {
			ctrl = cm
		}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	ctx := utility.MakeContext(map[string]any{
		"opname": "prepare",
		"ctrl":   ctrl,
	}, sdk.rootctx)

	options := sdk.options

	path, _ := vs.GetProp(fetchargs, "path").(string)
	method, _ := vs.GetProp(fetchargs, "method").(string)
	if method == "" {
		method = "GET"
	}

	params := ToMapAny(vs.GetProp(fetchargs, "params"))
	if params == nil {
		params = map[string]any{}
	}
	query := ToMapAny(vs.GetProp(fetchargs, "query"))
	if query == nil {
		query = map[string]any{}
	}

	headers := utility.PrepareHeaders(ctx)

	base, _ := vs.GetProp(options, "base").(string)
	prefix, _ := vs.GetProp(options, "prefix").(string)
	suffix, _ := vs.GetProp(options, "suffix").(string)

	ctx.Spec = NewSpec(map[string]any{
		"base":    base,
		"prefix":  prefix,
		"suffix":  suffix,
		"path":    path,
		"method":  method,
		"params":  params,
		"query":   query,
		"headers": headers,
		"body":    vs.GetProp(fetchargs, "body"),
		"step":    "start",
	})

	// Merge user-provided headers.
	if uh := vs.GetProp(fetchargs, "headers"); uh != nil {
		if uhm, ok := uh.(map[string]any); ok {
			for k, v := range uhm {
				ctx.Spec.Headers[k] = v
			}
		}
	}

	_, err := utility.PrepareAuth(ctx)
	if err != nil {
		return nil, err
	}

	return utility.MakeFetchDef(ctx)
}

func (sdk *GuildWars2SDK) Direct(fetchargs map[string]any) (map[string]any, error) {
	utility := sdk.utility

	fetchdef, err := sdk.Prepare(fetchargs)
	if err != nil {
		return map[string]any{"ok": false, "err": err}, nil
	}

	if fetchargs == nil {
		fetchargs = map[string]any{}
	}

	var ctrl map[string]any
	if c := vs.GetProp(fetchargs, "ctrl"); c != nil {
		if cm, ok := c.(map[string]any); ok {
			ctrl = cm
		}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	ctx := utility.MakeContext(map[string]any{
		"opname": "direct",
		"ctrl":   ctrl,
	}, sdk.rootctx)

	url, _ := fetchdef["url"].(string)
	fetched, fetchErr := utility.Fetcher(ctx, url, fetchdef)

	if fetchErr != nil {
		return map[string]any{"ok": false, "err": fetchErr}, nil
	}

	if fetched == nil {
		return map[string]any{
			"ok":  false,
			"err": ctx.MakeError("direct_no_response", "response: undefined"),
		}, nil
	}

	if fm, ok := fetched.(map[string]any); ok {
		status := ToInt(vs.GetProp(fm, "status"))
		headers := vs.GetProp(fm, "headers")

		// No-body responses (204, 304) and explicit zero content-length
		// must skip JSON parsing — calling json() on an empty body errors.
		var contentLength string
		if hm, ok := headers.(map[string]any); ok {
			if cl, ok := hm["content-length"]; ok {
				contentLength = fmt.Sprintf("%v", cl)
			}
		}
		noBody := status == 204 || status == 304 || contentLength == "0"

		var jsonData any
		if !noBody {
			if jf := vs.GetProp(fm, "json"); jf != nil {
				if f, ok := jf.(func() any); ok {
					// f() returns nil on parse error in our fetcher.
					jsonData = f()
				}
			}
		}

		return map[string]any{
			"ok":      status >= 200 && status < 300,
			"status":  status,
			"headers": headers,
			"data":    jsonData,
		}, nil
	}

	return map[string]any{"ok": false, "err": ctx.MakeError("direct_invalid", "invalid response type")}, nil
}


// Achievement returns a Achievement entity bound to this client.
// Idiomatic usage: client.Achievement(nil).List(nil, nil) or
// client.Achievement(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Achievement(data map[string]any) GuildWars2Entity {
	return NewAchievementEntityFunc(sdk, data)
}


// Authenticated returns a Authenticated entity bound to this client.
// Idiomatic usage: client.Authenticated(nil).List(nil, nil) or
// client.Authenticated(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Authenticated(data map[string]any) GuildWars2Entity {
	return NewAuthenticatedEntityFunc(sdk, data)
}


// DailyReward returns a DailyReward entity bound to this client.
// Idiomatic usage: client.DailyReward(nil).List(nil, nil) or
// client.DailyReward(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) DailyReward(data map[string]any) GuildWars2Entity {
	return NewDailyRewardEntityFunc(sdk, data)
}


// GameMechanic returns a GameMechanic entity bound to this client.
// Idiomatic usage: client.GameMechanic(nil).List(nil, nil) or
// client.GameMechanic(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) GameMechanic(data map[string]any) GuildWars2Entity {
	return NewGameMechanicEntityFunc(sdk, data)
}


// Guild returns a Guild entity bound to this client.
// Idiomatic usage: client.Guild(nil).List(nil, nil) or
// client.Guild(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Guild(data map[string]any) GuildWars2Entity {
	return NewGuildEntityFunc(sdk, data)
}


// GuildAuthenticated returns a GuildAuthenticated entity bound to this client.
// Idiomatic usage: client.GuildAuthenticated(nil).List(nil, nil) or
// client.GuildAuthenticated(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) GuildAuthenticated(data map[string]any) GuildWars2Entity {
	return NewGuildAuthenticatedEntityFunc(sdk, data)
}


// HomeInstance returns a HomeInstance entity bound to this client.
// Idiomatic usage: client.HomeInstance(nil).List(nil, nil) or
// client.HomeInstance(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) HomeInstance(data map[string]any) GuildWars2Entity {
	return NewHomeInstanceEntityFunc(sdk, data)
}


// Item returns a Item entity bound to this client.
// Idiomatic usage: client.Item(nil).List(nil, nil) or
// client.Item(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Item(data map[string]any) GuildWars2Entity {
	return NewItemEntityFunc(sdk, data)
}


// Map returns a Map entity bound to this client.
// Idiomatic usage: client.Map(nil).List(nil, nil) or
// client.Map(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Map(data map[string]any) GuildWars2Entity {
	return NewMapEntityFunc(sdk, data)
}


// MapInformation returns a MapInformation entity bound to this client.
// Idiomatic usage: client.MapInformation(nil).List(nil, nil) or
// client.MapInformation(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) MapInformation(data map[string]any) GuildWars2Entity {
	return NewMapInformationEntityFunc(sdk, data)
}


// Miscellaneous returns a Miscellaneous entity bound to this client.
// Idiomatic usage: client.Miscellaneous(nil).List(nil, nil) or
// client.Miscellaneous(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Miscellaneous(data map[string]any) GuildWars2Entity {
	return NewMiscellaneousEntityFunc(sdk, data)
}


// Story returns a Story entity bound to this client.
// Idiomatic usage: client.Story(nil).List(nil, nil) or
// client.Story(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) Story(data map[string]any) GuildWars2Entity {
	return NewStoryEntityFunc(sdk, data)
}


// StructuredPvP returns a StructuredPvP entity bound to this client.
// Idiomatic usage: client.StructuredPvP(nil).List(nil, nil) or
// client.StructuredPvP(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) StructuredPvP(data map[string]any) GuildWars2Entity {
	return NewStructuredPvPEntityFunc(sdk, data)
}


// TradingPost returns a TradingPost entity bound to this client.
// Idiomatic usage: client.TradingPost(nil).List(nil, nil) or
// client.TradingPost(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) TradingPost(data map[string]any) GuildWars2Entity {
	return NewTradingPostEntityFunc(sdk, data)
}


// WorldVsWorld returns a WorldVsWorld entity bound to this client.
// Idiomatic usage: client.WorldVsWorld(nil).List(nil, nil) or
// client.WorldVsWorld(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *GuildWars2SDK) WorldVsWorld(data map[string]any) GuildWars2Entity {
	return NewWorldVsWorldEntityFunc(sdk, data)
}



func TestSDK(testopts map[string]any, sdkopts map[string]any) *GuildWars2SDK {
	if sdkopts == nil {
		sdkopts = map[string]any{}
	}
	sdkopts = vs.Clone(sdkopts).(map[string]any)

	if testopts == nil {
		testopts = map[string]any{}
	}
	testopts = vs.Clone(testopts).(map[string]any)
	testopts["active"] = true

	vs.SetPath(sdkopts, []any{"feature", "test"}, testopts)

	sdk := NewGuildWars2SDK(sdkopts)
	sdk.Mode = "test"

	return sdk
}
