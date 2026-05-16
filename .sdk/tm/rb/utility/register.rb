# GuildWars2 SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

GuildWars2Utility.registrar = ->(u) {
  u.clean = GuildWars2Utilities::Clean
  u.done = GuildWars2Utilities::Done
  u.make_error = GuildWars2Utilities::MakeError
  u.feature_add = GuildWars2Utilities::FeatureAdd
  u.feature_hook = GuildWars2Utilities::FeatureHook
  u.feature_init = GuildWars2Utilities::FeatureInit
  u.fetcher = GuildWars2Utilities::Fetcher
  u.make_fetch_def = GuildWars2Utilities::MakeFetchDef
  u.make_context = GuildWars2Utilities::MakeContext
  u.make_options = GuildWars2Utilities::MakeOptions
  u.make_request = GuildWars2Utilities::MakeRequest
  u.make_response = GuildWars2Utilities::MakeResponse
  u.make_result = GuildWars2Utilities::MakeResult
  u.make_point = GuildWars2Utilities::MakePoint
  u.make_spec = GuildWars2Utilities::MakeSpec
  u.make_url = GuildWars2Utilities::MakeUrl
  u.param = GuildWars2Utilities::Param
  u.prepare_auth = GuildWars2Utilities::PrepareAuth
  u.prepare_body = GuildWars2Utilities::PrepareBody
  u.prepare_headers = GuildWars2Utilities::PrepareHeaders
  u.prepare_method = GuildWars2Utilities::PrepareMethod
  u.prepare_params = GuildWars2Utilities::PrepareParams
  u.prepare_path = GuildWars2Utilities::PreparePath
  u.prepare_query = GuildWars2Utilities::PrepareQuery
  u.result_basic = GuildWars2Utilities::ResultBasic
  u.result_body = GuildWars2Utilities::ResultBody
  u.result_headers = GuildWars2Utilities::ResultHeaders
  u.transform_request = GuildWars2Utilities::TransformRequest
  u.transform_response = GuildWars2Utilities::TransformResponse
}
