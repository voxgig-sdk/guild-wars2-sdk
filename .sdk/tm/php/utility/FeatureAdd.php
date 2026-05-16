<?php
declare(strict_types=1);

// GuildWars2 SDK utility: feature_add

class GuildWars2FeatureAdd
{
    public static function call(GuildWars2Context $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
