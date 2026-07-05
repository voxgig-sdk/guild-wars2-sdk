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
class AchievementListMatch
end

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
# @!attribute [rw] permission
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
  :permission,
  :subtoken,
  :value,
  :world,
  keyword_init: true
)

# Request payload for Authenticated#load.
#
# @!attribute [rw] created
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] permission
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
AuthenticatedLoadMatch = Struct.new(
  :created,
  :id,
  :name,
  :permission,
  :subtoken,
  :value,
  :world,
  keyword_init: true
)

# Request payload for Authenticated#list.
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
# @!attribute [rw] permission
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
AuthenticatedListMatch = Struct.new(
  :created,
  :id,
  :name,
  :permission,
  :subtoken,
  :value,
  :world,
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
class GameMechanicListMatch
end

# Guild entity data model.
class Guild
end

# Request payload for Guild#load.
#
# @!attribute [rw] id
#   @return [String]
GuildLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Guild#list.
class GuildListMatch
end

# GuildAuthenticated entity data model.
class GuildAuthenticated
end

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
class HomeInstanceListMatch
end

# Item entity data model.
class Item
end

# Request payload for Item#list.
class ItemListMatch
end

# Map entity data model.
class Map
end

# Request payload for Map#list.
class MapListMatch
end

# MapInformation entity data model.
class MapInformation
end

# Request payload for MapInformation#list.
class MapInformationListMatch
end

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
# @!attribute [rw] id
#   @return [Integer, nil]
MiscellaneousListMatch = Struct.new(
  :id,
  keyword_init: true
)

# Story entity data model.
class Story
end

# Request payload for Story#list.
class StoryListMatch
end

# StructuredPvP entity data model.
class StructuredPvP
end

# Request payload for StructuredPvP#list.
class StructuredPvPListMatch
end

# TradingPost entity data model.
#
# @!attribute [rw] coin
#   @return [Integer, nil]
#
# @!attribute [rw] coins_per_gem
#   @return [Integer, nil]
#
# @!attribute [rw] item
#   @return [Array, nil]
#
# @!attribute [rw] quantity
#   @return [Integer, nil]
TradingPost = Struct.new(
  :coin,
  :coins_per_gem,
  :item,
  :quantity,
  keyword_init: true
)

# Request payload for TradingPost#load.
#
# @!attribute [rw] coin
#   @return [Integer, nil]
#
# @!attribute [rw] coins_per_gem
#   @return [Integer, nil]
#
# @!attribute [rw] item
#   @return [Array, nil]
#
# @!attribute [rw] quantity
#   @return [Integer, nil]
TradingPostLoadMatch = Struct.new(
  :coin,
  :coins_per_gem,
  :item,
  :quantity,
  keyword_init: true
)

# Request payload for TradingPost#list.
#
# @!attribute [rw] coin
#   @return [Integer, nil]
#
# @!attribute [rw] coins_per_gem
#   @return [Integer, nil]
#
# @!attribute [rw] item
#   @return [Array, nil]
#
# @!attribute [rw] quantity
#   @return [Integer, nil]
TradingPostListMatch = Struct.new(
  :coin,
  :coins_per_gem,
  :item,
  :quantity,
  keyword_init: true
)

# WorldVsWorld entity data model.
class WorldVsWorld
end

# Request payload for WorldVsWorld#list.
class WorldVsWorldListMatch
end

