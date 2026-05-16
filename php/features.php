<?php
declare(strict_types=1);

// GuildWars2 SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class GuildWars2Features
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new GuildWars2BaseFeature();
            case "test":
                return new GuildWars2TestFeature();
            default:
                return new GuildWars2BaseFeature();
        }
    }
}
