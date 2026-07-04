// Typed models for the GuildWars2 SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Achievement {
}

export type AchievementLoadMatch = Partial<Achievement>

export type AchievementListMatch = Partial<Achievement>

export interface Authenticated {
  created?: string
  id?: string
  name?: string
  permission?: any[]
  subtoken?: string
  value?: number
  world?: number
}

export type AuthenticatedLoadMatch = Partial<Authenticated>

export type AuthenticatedListMatch = Partial<Authenticated>

export interface DailyReward {
}

export type DailyRewardListMatch = Partial<DailyReward>

export interface GameMechanic {
}

export type GameMechanicListMatch = Partial<GameMechanic>

export interface Guild {
}

export interface GuildLoadMatch {
  id: string
}

export type GuildListMatch = Partial<Guild>

export interface GuildAuthenticated {
}

export interface GuildAuthenticatedListMatch {
  id: string
}

export interface HomeInstance {
}

export type HomeInstanceListMatch = Partial<HomeInstance>

export interface Item {
}

export type ItemListMatch = Partial<Item>

export interface Map {
}

export type MapListMatch = Partial<Map>

export interface MapInformation {
}

export type MapInformationListMatch = Partial<MapInformation>

export interface Miscellaneous {
  id?: number
}

export type MiscellaneousLoadMatch = Partial<Miscellaneous>

export type MiscellaneousListMatch = Partial<Miscellaneous>

export interface Story {
}

export type StoryListMatch = Partial<Story>

export interface StructuredPvP {
}

export type StructuredPvPListMatch = Partial<StructuredPvP>

export interface TradingPost {
  coin?: number
  coins_per_gem?: number
  item?: any[]
  quantity?: number
}

export type TradingPostLoadMatch = Partial<TradingPost>

export type TradingPostListMatch = Partial<TradingPost>

export interface WorldVsWorld {
}

export type WorldVsWorldListMatch = Partial<WorldVsWorld>

