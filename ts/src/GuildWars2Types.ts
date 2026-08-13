// Typed models for the GuildWars2 SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Achievement {
}

export interface AchievementLoadMatch {

  // Selects a custom action instead of the plain load:
  //   'daily'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface AchievementListMatch {

  // Selects a custom action instead of the plain list:
  //   'category' | 'group'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface Authenticated {
  created?: string
  id?: string
  name?: string
  permissions?: any[]
  subtoken?: string
  value?: number
  world?: number
}

export interface AuthenticatedLoadMatch {
  created?: string
  id: string
  name?: string
  permissions?: any[]
  subtoken?: string
  value?: number
  world?: number
}

export interface AuthenticatedListMatch {
  created?: string
  id?: string
  name?: string
  permissions?: any[]
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

  // Selects a custom action instead of the plain list:
  //   'permission' | 'search' | 'upgrade'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface GuildAuthenticated {
}

export interface GuildAuthenticatedListMatch {
  id: string

  // Selects a custom action instead of the plain list:
  //   'log' | 'members' | 'ranks' | 'stash' | 'storage' | 'teams' | 'treasury' | 'upgrades'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
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

  // Selects a custom action instead of the plain list:
  //   'season'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface StructuredPvP {
}

export interface StructuredPvPListMatch {
}

export interface TradingPost {
  coins?: number
  coins_per_gem?: number
  items?: any[]
  quantity?: number
}

export interface TradingPostLoadMatch {
  coins?: number
  coins_per_gem?: number
  items?: any[]
  quantity?: number
}

export interface TradingPostListMatch {
  coins?: number
  coins_per_gem?: number
  items?: any[]
  quantity?: number
}

export interface WorldVsWorld {
}

export interface WorldVsWorldListMatch {
}

