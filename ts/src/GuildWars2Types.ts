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
  ids?: string
  v?: string

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
  expire?: string
  permission?: string
  url?: string
}

export interface AuthenticatedListMatch {
  ids?: string
}

export interface DailyReward {
}

export interface DailyRewardListMatch {
}

export interface GameMechanic {
}

export interface GameMechanicListMatch {
  ids?: string
}

export interface Guild {
  id?: string
}

export interface GuildLoadMatch {
  id: string
}

export interface GuildListMatch {
  id?: string

  // Selects a custom action instead of the plain list:
  //   'permission' | 'search' | 'upgrade'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface GuildAuthenticated {
  id?: string
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
  ids?: string
}

export interface Item {
}

export interface ItemListMatch {
  ids?: string
}

export interface MapType {
}

export interface MapListMatch {
  ids?: string
}

export interface MapInformation {
}

export interface MapInformationListMatch {
  ids?: string
}

export interface Miscellaneous {
  id?: number
}

export interface MiscellaneousLoadMatch {
  id: number
}

export interface MiscellaneousListMatch {
  ids?: string
}

export interface Story {
}

export interface StoryListMatch {
  ids?: string

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
  quantity: number
}

export interface TradingPostListMatch {
  ids?: string
}

export interface WorldVsWorld {
}

export interface WorldVsWorldListMatch {
}

