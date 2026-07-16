-- WorldVsWorld entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("guild-wars2_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

describe("WorldVsWorldEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:WorldVsWorld(nil)
    assert.is_not_nil(ent)
  end)

  -- Feature #4: the entity stream(action, ...) method runs the op pipeline and
  -- returns an iterator over result items. With the streaming feature active it
  -- yields the feature's incremental output; otherwise it falls back to the
  -- materialised list so stream always yields.
  it("should stream", function()
    local seed = {
      entity = {
        ["world_vs_world"] = {
          s1 = { id = "s1" },
          s2 = { id = "s2" },
          s3 = { id = "s3" },
        },
      },
    }

    -- Fallback: streaming inactive -> yields the materialised list items.
    local base = sdk.test(seed, nil)
    local seen = {}
    for item in base:WorldVsWorld(nil):stream("list", nil, nil) do
      table.insert(seen, item)
    end
    assert.are.equal(3, #seen)

    -- Inbound: streaming active -> yields each item from the feature.
    local config = require("config")()
    if type(config.feature) == "table" and config.feature.streaming ~= nil then
      local streamsdk = sdk.test(seed, { feature = { streaming = { active = true } } })
      local got = {}
      for item in streamsdk:WorldVsWorld(nil):stream("list", nil, nil) do
        if vs.islist(item) then
          for _, sub in ipairs(item) do
            table.insert(got, sub)
          end
        else
          table.insert(got, item)
        end
      end
      assert.are.equal(3, #got)
    end
  end)

  it("should run basic flow", function()
    local setup = world_vs_world_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"list"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "world_vs_world." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    -- The basic flow consumes synthetic IDs from the fixture. In live mode
    -- without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only then
      pending("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_WORLD_VS_WORLD_ENTID JSON to run live")
      return
    end
    local client = setup.client

    -- Bootstrap entity data from existing test data.
    local world_vs_world_ref01_data_raw = vs.items(helpers.to_map(
      vs.getpath(setup.data, "existing.world_vs_world")))
    local world_vs_world_ref01_data = nil
    if #world_vs_world_ref01_data_raw > 0 then
      world_vs_world_ref01_data = helpers.to_map(world_vs_world_ref01_data_raw[1][2])
    end

    -- LIST
    local world_vs_world_ref01_ent = client:WorldVsWorld(nil)
    local world_vs_world_ref01_match = {}

    local world_vs_world_ref01_list_result, err = world_vs_world_ref01_ent:list(world_vs_world_ref01_match, nil)
    assert.is_nil(err)
    assert.is_table(world_vs_world_ref01_list_result)

  end)
end)

function world_vs_world_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/world_vs_world/WorldVsWorldTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read world_vs_world test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "world_vs_world01", "world_vs_world02", "world_vs_world03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Detect ENTID env override before envOverride consumes it. When live
  -- mode is on without a real override, the basic test runs against synthetic
  -- IDs from the fixture and 4xx's. Surface this so the test can skip.
  local entid_env_raw = os.getenv("GUILDWARS__TEST_WORLD_VS_WORLD_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["GUILDWARS__TEST_WORLD_VS_WORLD_ENTID"] = idmap,
    ["GUILDWARS__TEST_LIVE"] = "FALSE",
    ["GUILDWARS__TEST_EXPLAIN"] = "FALSE",
    ["GUILDWARS__APIKEY"] = "NONE",
  })

  local idmap_resolved = helpers.to_map(
    env["GUILDWARS__TEST_WORLD_VS_WORLD_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["GUILDWARS__TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      {
        apikey = env["GUILDWARS__APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["GUILDWARS__TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["GUILDWARS__TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
