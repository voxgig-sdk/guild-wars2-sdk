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
---@field ids? string
---@field v? string

---@class Authenticated
---@field created? string
---@field id? string
---@field name? string
---@field permissions? table
---@field subtoken? string
---@field value? number
---@field world? number

---@class AuthenticatedLoadMatch
---@field expire? string
---@field permission? string
---@field url? string

---@class AuthenticatedListMatch
---@field ids? string

---@class DailyReward

---@class DailyRewardListMatch

---@class GameMechanic

---@class GameMechanicListMatch
---@field ids? string

---@class Guild
---@field id? string

---@class GuildLoadMatch
---@field id string

---@class GuildListMatch
---@field id? string

---@class GuildAuthenticated
---@field id? string

---@class GuildAuthenticatedListMatch
---@field id string

---@class HomeInstance

---@class HomeInstanceListMatch
---@field ids? string

---@class Item

---@class ItemListMatch
---@field ids? string

---@class Map

---@class MapListMatch
---@field ids? string

---@class MapInformation

---@class MapInformationListMatch
---@field ids? string

---@class Miscellaneous
---@field id? number

---@class MiscellaneousLoadMatch
---@field id number

---@class MiscellaneousListMatch
---@field ids? string

---@class Story

---@class StoryListMatch
---@field ids? string

---@class StructuredPvP

---@class StructuredPvPListMatch

---@class TradingPost
---@field coins? number
---@field coins_per_gem? number
---@field items? table
---@field quantity? number

---@class TradingPostLoadMatch
---@field quantity number

---@class TradingPostListMatch
---@field ids? string

---@class WorldVsWorld

---@class WorldVsWorldListMatch

local M = {}

return M
