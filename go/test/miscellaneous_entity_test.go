package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/guild-wars2-sdk"
	"github.com/voxgig-sdk/guild-wars2-sdk/core"

	vs "github.com/voxgig/struct"
)

func TestMiscellaneousEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Miscellaneous(nil)
		if ent == nil {
			t.Fatal("expected non-nil MiscellaneousEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := miscellaneousBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "miscellaneous." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_MISCELLANEOUS_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		miscellaneousRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.miscellaneous", setup.data)))
		var miscellaneousRef01Data map[string]any
		if len(miscellaneousRef01DataRaw) > 0 {
			miscellaneousRef01Data = core.ToMapAny(miscellaneousRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = miscellaneousRef01Data

		// LIST
		miscellaneousRef01Ent := client.Miscellaneous(nil)
		miscellaneousRef01Match := map[string]any{}

		miscellaneousRef01ListResult, err := miscellaneousRef01Ent.List(miscellaneousRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, miscellaneousRef01ListOk := miscellaneousRef01ListResult.([]any)
		if !miscellaneousRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", miscellaneousRef01ListResult)
		}

		// LOAD
		miscellaneousRef01MatchDt0 := map[string]any{
			"id": miscellaneousRef01Data["id"],
		}
		miscellaneousRef01DataDt0Loaded, err := miscellaneousRef01Ent.Load(miscellaneousRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		miscellaneousRef01DataDt0LoadResult := core.ToMapAny(miscellaneousRef01DataDt0Loaded)
		if miscellaneousRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if miscellaneousRef01DataDt0LoadResult["id"] != miscellaneousRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func miscellaneousBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "miscellaneous", "MiscellaneousTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read miscellaneous test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse miscellaneous test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"miscellaneous01", "miscellaneous02", "miscellaneous03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("GUILDWARS__TEST_MISCELLANEOUS_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"GUILDWARS__TEST_MISCELLANEOUS_ENTID": idmap,
		"GUILDWARS__TEST_LIVE":      "FALSE",
		"GUILDWARS__TEST_EXPLAIN":   "FALSE",
		"GUILDWARS__APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["GUILDWARS__TEST_MISCELLANEOUS_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["GUILDWARS__TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["GUILDWARS__APIKEY"],
			},
			extra,
		})
		client = sdk.NewGuildWars2SDK(core.ToMapAny(mergedOpts))
	}

	live := env["GUILDWARS__TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["GUILDWARS__TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
