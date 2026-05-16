<?php
declare(strict_types=1);

// GuildWars2 SDK exists test

require_once __DIR__ . '/../guildwars2_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = GuildWars2SDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
