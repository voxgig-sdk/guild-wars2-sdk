<?php
declare(strict_types=1);

// GuildWars2 SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

GuildWars2Utility::setRegistrar(function (GuildWars2Utility $u): void {
    $u->clean = [GuildWars2Clean::class, 'call'];
    $u->done = [GuildWars2Done::class, 'call'];
    $u->make_error = [GuildWars2MakeError::class, 'call'];
    $u->feature_add = [GuildWars2FeatureAdd::class, 'call'];
    $u->feature_hook = [GuildWars2FeatureHook::class, 'call'];
    $u->feature_init = [GuildWars2FeatureInit::class, 'call'];
    $u->fetcher = [GuildWars2Fetcher::class, 'call'];
    $u->make_fetch_def = [GuildWars2MakeFetchDef::class, 'call'];
    $u->make_context = [GuildWars2MakeContext::class, 'call'];
    $u->make_options = [GuildWars2MakeOptions::class, 'call'];
    $u->make_request = [GuildWars2MakeRequest::class, 'call'];
    $u->make_response = [GuildWars2MakeResponse::class, 'call'];
    $u->make_result = [GuildWars2MakeResult::class, 'call'];
    $u->make_point = [GuildWars2MakePoint::class, 'call'];
    $u->make_spec = [GuildWars2MakeSpec::class, 'call'];
    $u->make_url = [GuildWars2MakeUrl::class, 'call'];
    $u->param = [GuildWars2Param::class, 'call'];
    $u->prepare_auth = [GuildWars2PrepareAuth::class, 'call'];
    $u->prepare_body = [GuildWars2PrepareBody::class, 'call'];
    $u->prepare_headers = [GuildWars2PrepareHeaders::class, 'call'];
    $u->prepare_method = [GuildWars2PrepareMethod::class, 'call'];
    $u->prepare_params = [GuildWars2PrepareParams::class, 'call'];
    $u->prepare_path = [GuildWars2PreparePath::class, 'call'];
    $u->prepare_query = [GuildWars2PrepareQuery::class, 'call'];
    $u->result_basic = [GuildWars2ResultBasic::class, 'call'];
    $u->result_body = [GuildWars2ResultBody::class, 'call'];
    $u->result_headers = [GuildWars2ResultHeaders::class, 'call'];
    $u->transform_request = [GuildWars2TransformRequest::class, 'call'];
    $u->transform_response = [GuildWars2TransformResponse::class, 'call'];
});
