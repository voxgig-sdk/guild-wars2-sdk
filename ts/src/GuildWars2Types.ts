// Typed models for the GuildWars2 SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Achievement {
}

export interface AchievementLoadMatch {
}

export interface AchievementListMatch {
}

export interface Authenticated {
  created?: string
  id?: string
  name?: string
  permission?: any[]
  subtoken?: string
  value?: number
  world?: number
}

export interface AuthenticatedLoadMatch {
  created?: string
  id: string
  name?: string
  permission?: any[]
  subtoken?: string
  value?: number
  world?: number
}

export interface AuthenticatedListMatch {
  created?: string
  id?: string
  name?: string
  permission?: any[]
  subtoken?: string
  value?: number
  world?: number
}

export interface DailyReward {
}

export interface DailyRewardListMatch {
}

export interface GameMechanic {
}

export interface GameMechanicListMatch {
}

export interface Guild {
}

export interface GuildLoadMatch {
  id: string
}

export interface GuildListMatch {
}

export interface GuildAuthenticated {
}

export interface GuildAuthenticatedListMatch {
  id: string
}

export interface HomeInstance {
}

export interface HomeInstanceListMatch {
}

export interface Item {
}

export interface ItemListMatch {
}

export interface Map {
}

export interface MapListMatch {
}

export interface MapInformation {
}

export interface MapInformationListMatch {
}

export interface Miscellaneous {
  id?: number
}

export interface MiscellaneousLoadMatch {
  id: number
}

export interface MiscellaneousListMatch {
  id?: number
}

export interface Story {
}

export interface StoryListMatch {
}

export interface StructuredPvP {
}

export interface StructuredPvPListMatch {
}

export interface TradingPost {
  coin?: number
  coins_per_gem?: number
  item?: any[]
  quantity?: number
}

export interface TradingPostLoadMatch {
  coin?: number
  coins_per_gem?: number
  item?: any[]
  quantity?: number
}

export interface TradingPostListMatch {
  coin?: number
  coins_per_gem?: number
  item?: any[]
  quantity?: number
}

export interface WorldVsWorld {
}

export interface WorldVsWorldListMatch {
}

