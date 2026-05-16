# Map entity test

require "minitest/autorun"
require "json"
require_relative "../GuildWars2_sdk"
require_relative "runner"

class MapEntityTest < Minitest::Test
  def test_create_instance
    testsdk = GuildWars2SDK.test(nil, nil)
    ent = testsdk.Map(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = map_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["list"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "map." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_MAP_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    map_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.map")))
    map_ref01_data = nil
    if map_ref01_data_raw.length > 0
      map_ref01_data = Helpers.to_map(map_ref01_data_raw[0][1])
    end

    # LIST
    map_ref01_ent = client.Map(nil)
    map_ref01_match = {}

    map_ref01_list_result, err = map_ref01_ent.list(map_ref01_match, nil)
    assert_nil err
    assert map_ref01_list_result.is_a?(Array)

  end
end

def map_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "map", "MapTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = GuildWars2SDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["map01", "map02", "map03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["GUILDWARS__TEST_MAP_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "GUILDWARS__TEST_MAP_ENTID" => idmap,
    "GUILDWARS__TEST_LIVE" => "FALSE",
    "GUILDWARS__TEST_EXPLAIN" => "FALSE",
    "GUILDWARS__APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["GUILDWARS__TEST_MAP_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["GUILDWARS__TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["GUILDWARS__APIKEY"],
      },
      extra || {},
    ])
    client = GuildWars2SDK.new(Helpers.to_map(merged_opts))
  end

  live = env["GUILDWARS__TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["GUILDWARS__TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
