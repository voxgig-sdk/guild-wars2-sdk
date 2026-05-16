<?php
declare(strict_types=1);

// GuildWars2 SDK utility: feature_hook

class GuildWars2FeatureHook
{
    public static function call(GuildWars2Context $ctx, string $name): void
    {
        if (!$ctx->client) {
            return;
        }
        $features = $ctx->client->features ?? null;
        if (!$features) {
            return;
        }
        foreach ($features as $f) {
            if (method_exists($f, $name)) {
                $f->$name($ctx);
            }
        }
    }
}
