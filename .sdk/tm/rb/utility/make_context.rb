# GuildWars2 SDK utility: make_context
require_relative '../core/context'
module GuildWars2Utilities
  MakeContext = ->(ctxmap, basectx) {
    GuildWars2Context.new(ctxmap, basectx)
  }
end
