# GuildWars2 SDK exists test

require "minitest/autorun"
require_relative "../GuildWars2_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = GuildWars2SDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
