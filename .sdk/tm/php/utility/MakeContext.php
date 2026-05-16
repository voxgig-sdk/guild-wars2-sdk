<?php
declare(strict_types=1);

// GuildWars2 SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class GuildWars2MakeContext
{
    public static function call(array $ctxmap, ?GuildWars2Context $basectx): GuildWars2Context
    {
        return new GuildWars2Context($ctxmap, $basectx);
    }
}
