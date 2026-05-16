<?php
declare(strict_types=1);

// GuildWars2 SDK utility: result_body

class GuildWars2ResultBody
{
    public static function call(GuildWars2Context $ctx): ?GuildWars2Result
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
