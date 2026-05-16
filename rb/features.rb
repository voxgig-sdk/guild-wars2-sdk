# GuildWars2 SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module GuildWars2Features
  def self.make_feature(name)
    case name
    when "base"
      GuildWars2BaseFeature.new
    when "test"
      GuildWars2TestFeature.new
    else
      GuildWars2BaseFeature.new
    end
  end
end
