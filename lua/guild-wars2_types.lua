-- Typed models for the GuildWars2 SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Achievement

---@class AchievementLoadMatch

---@class AchievementListMatch

---@class Authenticated
---@field created? string
---@field id? string
---@field name? string
---@field permission? table
---@field subtoken? string
---@field value? number
---@field world? number

---@class AuthenticatedLoadMatch
---@field created? string
---@field id string
---@field name? string
---@field permission? table
---@field subtoken? string
---@field value? number
---@field world? number

---@class AuthenticatedListMatch
---@field created? string
---@field id? string
---@field name? string
---@field permission? table
---@field subtoken? string
---@field value? number
---@field world? number

---@class DailyReward

---@class DailyRewardListMatch

---@class GameMechanic

---@class GameMechanicListMatch

---@class Guild

---@class GuildLoadMatch
---@field id string

---@class GuildListMatch

---@class GuildAuthenticated

---@class GuildAuthenticatedListMatch
---@field id string

---@class HomeInstance

---@class HomeInstanceListMatch

---@class Item

---@class ItemListMatch

---@class Map

---@class MapListMatch

---@class MapInformation

---@class MapInformationListMatch

---@class Miscellaneous
---@field id? number

---@class MiscellaneousLoadMatch
---@field id number

---@class MiscellaneousListMatch
---@field id? number

---@class Story

---@class StoryListMatch

---@class StructuredPvP

---@class StructuredPvPListMatch

---@class TradingPost
---@field coin? number
---@field coins_per_gem? number
---@field item? table
---@field quantity? number

---@class TradingPostLoadMatch
---@field coin? number
---@field coins_per_gem? number
---@field item? table
---@field quantity? number

---@class TradingPostListMatch
---@field coin? number
---@field coins_per_gem? number
---@field item? table
---@field quantity? number

---@class WorldVsWorld

---@class WorldVsWorldListMatch

local M = {}

return M
