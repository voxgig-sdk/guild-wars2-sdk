export interface Achievement {
}
export interface AchievementLoadMatch {
    $action?: string;
    [action: string]: any;
}
export interface AchievementListMatch {
    ids?: string;
    v?: string;
    $action?: string;
    [action: string]: any;
}
export interface Authenticated {
    created?: string;
    id?: string;
    name?: string;
    permissions?: any[];
    subtoken?: string;
    value?: number;
    world?: number;
}
export interface AuthenticatedLoadMatch {
    expire?: string;
    permission?: string;
    url?: string;
}
export interface AuthenticatedListMatch {
    ids?: string;
}
export interface DailyReward {
}
export interface DailyRewardListMatch {
}
export interface GameMechanic {
}
export interface GameMechanicListMatch {
    ids?: string;
}
export interface Guild {
    id?: string;
}
export interface GuildLoadMatch {
    id: string;
}
export interface GuildListMatch {
    id?: string;
    $action?: string;
    [action: string]: any;
}
export interface GuildAuthenticated {
    id?: string;
}
export interface GuildAuthenticatedListMatch {
    id: string;
    $action?: string;
    [action: string]: any;
}
export interface HomeInstance {
}
export interface HomeInstanceListMatch {
    ids?: string;
}
export interface Item {
}
export interface ItemListMatch {
    ids?: string;
}
export interface MapType {
}
export interface MapListMatch {
    ids?: string;
}
export interface MapInformation {
}
export interface MapInformationListMatch {
    ids?: string;
}
export interface Miscellaneous {
    id?: number;
}
export interface MiscellaneousLoadMatch {
    id: number;
}
export interface MiscellaneousListMatch {
    ids?: string;
}
export interface Story {
}
export interface StoryListMatch {
    ids?: string;
    $action?: string;
    [action: string]: any;
}
export interface StructuredPvP {
}
export interface StructuredPvPListMatch {
}
export interface TradingPost {
    coins?: number;
    coins_per_gem?: number;
    items?: any[];
    quantity?: number;
}
export interface TradingPostLoadMatch {
    quantity: number;
}
export interface TradingPostListMatch {
    ids?: string;
}
export interface WorldVsWorld {
}
export interface WorldVsWorldListMatch {
}
