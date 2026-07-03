<?php
declare(strict_types=1);

// HomeInstance entity test

require_once __DIR__ . '/../guildwars2_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class HomeInstanceEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = GuildWars2SDK::test(null, null);
        $ent = $testsdk->HomeInstance(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = home_instance_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["list"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "home_instance." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set GUILDWARS__TEST_HOME_INSTANCE_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // Bootstrap entity data from existing test data.
        $home_instance_ref01_data_raw = Vs::items(Helpers::to_map(
            Vs::getpath($setup["data"], "existing.home_instance")));
        $home_instance_ref01_data = null;
        if (count($home_instance_ref01_data_raw) > 0) {
            $home_instance_ref01_data = Helpers::to_map($home_instance_ref01_data_raw[0][1]);
        }

        // LIST
        $home_instance_ref01_ent = $client->HomeInstance(null);
        $home_instance_ref01_match = [];

        [$home_instance_ref01_list_result, $err] = $home_instance_ref01_ent->list($home_instance_ref01_match, null);
        $this->assertNull($err);
        $this->assertIsArray($home_instance_ref01_list_result);

    }
}

function home_instance_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/home_instance/HomeInstanceTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = GuildWars2SDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["home_instance01", "home_instance02", "home_instance03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("GUILDWARS__TEST_HOME_INSTANCE_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "GUILDWARS__TEST_HOME_INSTANCE_ENTID" => $idmap,
        "GUILDWARS__TEST_LIVE" => "FALSE",
        "GUILDWARS__TEST_EXPLAIN" => "FALSE",
        "GUILDWARS__APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["GUILDWARS__TEST_HOME_INSTANCE_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["GUILDWARS__TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["GUILDWARS__APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new GuildWars2SDK(Helpers::to_map($merged_opts));
    }

    $live = $env["GUILDWARS__TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["GUILDWARS__TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
