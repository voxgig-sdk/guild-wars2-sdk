# frozen_string_literal: true

# Typed models for the GuildWars2 SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Achievement entity data model.
class Achievement
end

# Request payload for Achievement#load.
class AchievementLoadMatch
end

# Request payload for Achievement#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
#
# @!attribute [rw] v
#   @return [String, nil]
AchievementListMatch = Struct.new(
  :ids,
  :v,
  keyword_init: true
)

# Authenticated entity data model.
#
# @!attribute [rw] created
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] permissions
#   @return [Array, nil]
#
# @!attribute [rw] subtoken
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [Integer, nil]
#
# @!attribute [rw] world
#   @return [Integer, nil]
Authenticated = Struct.new(
  :created,
  :id,
  :name,
  :permissions,
  :subtoken,
  :value,
  :world,
  keyword_init: true
)

# Request payload for Authenticated#load.
#
# @!attribute [rw] expire
#   @return [String, nil]
#
# @!attribute [rw] permission
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
AuthenticatedLoadMatch = Struct.new(
  :expire,
  :permission,
  :url,
  keyword_init: true
)

# Request payload for Authenticated#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
AuthenticatedListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# DailyReward entity data model.
class DailyReward
end

# Request payload for DailyReward#list.
class DailyRewardListMatch
end

# GameMechanic entity data model.
class GameMechanic
end

# Request payload for GameMechanic#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
GameMechanicListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# Guild entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
Guild = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Guild#load.
#
# @!attribute [rw] id
#   @return [String]
GuildLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Guild#list.
#
# @!attribute [rw] id
#   @return [String, nil]
GuildListMatch = Struct.new(
  :id,
  keyword_init: true
)

# GuildAuthenticated entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
GuildAuthenticated = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for GuildAuthenticated#list.
#
# @!attribute [rw] id
#   @return [String]
GuildAuthenticatedListMatch = Struct.new(
  :id,
  keyword_init: true
)

# HomeInstance entity data model.
class HomeInstance
end

# Request payload for HomeInstance#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
HomeInstanceListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# Item entity data model.
class Item
end

# Request payload for Item#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
ItemListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# Map entity data model.
class Map
end

# Request payload for Map#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
MapListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# MapInformation entity data model.
class MapInformation
end

# Request payload for MapInformation#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
MapInformationListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# Miscellaneous entity data model.
#
# @!attribute [rw] id
#   @return [Integer, nil]
Miscellaneous = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Miscellaneous#load.
#
# @!attribute [rw] id
#   @return [Integer]
MiscellaneousLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Miscellaneous#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
MiscellaneousListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# Story entity data model.
class Story
end

# Request payload for Story#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
StoryListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# StructuredPvP entity data model.
class StructuredPvP
end

# Request payload for StructuredPvP#list.
class StructuredPvPListMatch
end

# TradingPost entity data model.
#
# @!attribute [rw] coins
#   @return [Integer, nil]
#
# @!attribute [rw] coins_per_gem
#   @return [Integer, nil]
#
# @!attribute [rw] items
#   @return [Array, nil]
#
# @!attribute [rw] quantity
#   @return [Integer, nil]
TradingPost = Struct.new(
  :coins,
  :coins_per_gem,
  :items,
  :quantity,
  keyword_init: true
)

# Request payload for TradingPost#load.
#
# @!attribute [rw] quantity
#   @return [Integer]
TradingPostLoadMatch = Struct.new(
  :quantity,
  keyword_init: true
)

# Request payload for TradingPost#list.
#
# @!attribute [rw] ids
#   @return [String, nil]
TradingPostListMatch = Struct.new(
  :ids,
  keyword_init: true
)

# WorldVsWorld entity data model.
class WorldVsWorld
end

# Request payload for WorldVsWorld#list.
class WorldVsWorldListMatch
end

