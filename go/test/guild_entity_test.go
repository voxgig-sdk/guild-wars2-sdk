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

func TestGuildEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Guild(nil)
		if ent == nil {
			t.Fatal("expected non-nil GuildEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := guildBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "guild." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_GUILD_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		guildRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.guild", setup.data)))
		var guildRef01Data map[string]any
		if len(guildRef01DataRaw) > 0 {
			guildRef01Data = core.ToMapAny(guildRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = guildRef01Data

		// LIST
		guildRef01Ent := client.Guild(nil)
		guildRef01Match := map[string]any{}

		guildRef01ListResult, err := guildRef01Ent.List(guildRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, guildRef01ListOk := guildRef01ListResult.([]any)
		if !guildRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", guildRef01ListResult)
		}

		// LOAD
		guildRef01MatchDt0 := map[string]any{}
		guildRef01DataDt0Loaded, err := guildRef01Ent.Load(guildRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		if guildRef01DataDt0Loaded == nil {
			t.Fatal("expected load result to be non-nil")
		}

	})
}

func guildBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "guild", "GuildTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read guild test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse guild test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"guild01", "guild02", "guild03"},
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
	entidEnvRaw := os.Getenv("GUILDWARS__TEST_GUILD_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"GUILDWARS__TEST_GUILD_ENTID": idmap,
		"GUILDWARS__TEST_LIVE":      "FALSE",
		"GUILDWARS__TEST_EXPLAIN":   "FALSE",
	})

	idmapResolved := core.ToMapAny(env["GUILDWARS__TEST_GUILD_ENTID"])
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
