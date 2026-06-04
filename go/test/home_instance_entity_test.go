package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/guild-wars2-sdk/go"
	"github.com/voxgig-sdk/guild-wars2-sdk/go/core"

	vs "github.com/voxgig-sdk/guild-wars2-sdk/go/utility/struct"
)

func TestHomeInstanceEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.HomeInstance(nil)
		if ent == nil {
			t.Fatal("expected non-nil HomeInstanceEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := home_instanceBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "home_instance." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_HOME_INSTANCE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		homeInstanceRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.home_instance", setup.data)))
		var homeInstanceRef01Data map[string]any
		if len(homeInstanceRef01DataRaw) > 0 {
			homeInstanceRef01Data = core.ToMapAny(homeInstanceRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = homeInstanceRef01Data

		// LIST
		homeInstanceRef01Ent := client.HomeInstance(nil)
		homeInstanceRef01Match := map[string]any{}

		homeInstanceRef01ListResult, err := homeInstanceRef01Ent.List(homeInstanceRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, homeInstanceRef01ListOk := homeInstanceRef01ListResult.([]any)
		if !homeInstanceRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", homeInstanceRef01ListResult)
		}

	})
}

func home_instanceBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "home_instance", "HomeInstanceTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read home_instance test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse home_instance test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"home_instance01", "home_instance02", "home_instance03"},
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
	entidEnvRaw := os.Getenv("GUILDWARS__TEST_HOME_INSTANCE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"GUILDWARS__TEST_HOME_INSTANCE_ENTID": idmap,
		"GUILDWARS__TEST_LIVE":      "FALSE",
		"GUILDWARS__TEST_EXPLAIN":   "FALSE",
	})

	idmapResolved := core.ToMapAny(env["GUILDWARS__TEST_HOME_INSTANCE_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["GUILDWARS__TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
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
