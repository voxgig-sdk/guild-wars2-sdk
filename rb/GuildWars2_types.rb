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

# Match filter for Achievement#load (any subset of Achievement fields).
class AchievementLoadMatch
end

# Match filter for Achievement#list (any subset of Achievement fields).
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

# Match filter for Authenticated#load (any subset of Authenticated fields).
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

# Match filter for Authenticated#list (any subset of Authenticated fields).
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

# Match filter for DailyReward#list (any subset of DailyReward fields).
class DailyRewardListMatch
end

# GameMechanic entity data model.
class GameMechanic
end

# Match filter for GameMechanic#list (any subset of GameMechanic fields).
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

# Match filter for Guild#list (any subset of Guild fields).
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

# Match filter for HomeInstance#list (any subset of HomeInstance fields).
class HomeInstanceListMatch
end

# Item entity data model.
class Item
end

# Match filter for Item#list (any subset of Item fields).
class ItemListMatch
end

# Map entity data model.
class Map
end

# Match filter for Map#list (any subset of Map fields).
class MapListMatch
end

# MapInformation entity data model.
class MapInformation
end

# Match filter for MapInformation#list (any subset of MapInformation fields).
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

# Match filter for Miscellaneous#load (any subset of Miscellaneous fields).
#
# @!attribute [rw] id
#   @return [Integer, nil]
MiscellaneousLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Match filter for Miscellaneous#list (any subset of Miscellaneous fields).
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

# Match filter for Story#list (any subset of Story fields).
class StoryListMatch
end

# StructuredPvP entity data model.
class StructuredPvP
end

# Match filter for StructuredPvP#list (any subset of StructuredPvP fields).
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

# Match filter for TradingPost#load (any subset of TradingPost fields).
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

# Match filter for TradingPost#list (any subset of TradingPost fields).
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

# Match filter for WorldVsWorld#list (any subset of WorldVsWorld fields).
class WorldVsWorldListMatch
end

