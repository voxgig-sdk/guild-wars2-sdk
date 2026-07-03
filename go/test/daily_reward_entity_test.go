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

func TestDailyRewardEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.DailyReward(nil)
		if ent == nil {
			t.Fatal("expected non-nil DailyRewardEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := daily_rewardBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "daily_reward." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_DAILY_REWARD_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		dailyRewardRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.daily_reward", setup.data)))
		var dailyRewardRef01Data map[string]any
		if len(dailyRewardRef01DataRaw) > 0 {
			dailyRewardRef01Data = core.ToMapAny(dailyRewardRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = dailyRewardRef01Data

		// LIST
		dailyRewardRef01Ent := client.DailyReward(nil)
		dailyRewardRef01Match := map[string]any{}

		dailyRewardRef01ListResult, err := dailyRewardRef01Ent.List(dailyRewardRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, dailyRewardRef01ListOk := dailyRewardRef01ListResult.([]any)
		if !dailyRewardRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", dailyRewardRef01ListResult)
		}

	})
}

func daily_rewardBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "daily_reward", "DailyRewardTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read daily_reward test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse daily_reward test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"daily_reward01", "daily_reward02", "daily_reward03"},
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
	entidEnvRaw := os.Getenv("GUILDWARS__TEST_DAILY_REWARD_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"GUILDWARS__TEST_DAILY_REWARD_ENTID": idmap,
		"GUILDWARS__TEST_LIVE":      "FALSE",
		"GUILDWARS__TEST_EXPLAIN":   "FALSE",
		"GUILDWARS__APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["GUILDWARS__TEST_DAILY_REWARD_ENTID"])
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
