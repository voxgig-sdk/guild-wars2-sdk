<?php
declare(strict_types=1);

// GuildWars2 SDK utility: prepare_body

class GuildWars2PrepareBody
{
    public static function call(GuildWars2Context $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
