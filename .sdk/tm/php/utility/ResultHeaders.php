<?php
declare(strict_types=1);

// GuildWars2 SDK utility: result_headers

class GuildWars2ResultHeaders
{
    public static function call(GuildWars2Context $ctx): ?GuildWars2Result
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
