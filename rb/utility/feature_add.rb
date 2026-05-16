# GuildWars2 SDK utility: feature_add
module GuildWars2Utilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
