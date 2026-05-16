package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewAchievementEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewAuthenticatedEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewDailyRewardEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewGameMechanicEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewGuildEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewGuildAuthenticatedEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewHomeInstanceEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewItemEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewMapEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewMapInformationEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewMiscellaneousEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewStoryEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewStructuredPvPEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewTradingPostEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

var NewWorldVsWorldEntityFunc func(client *GuildWars2SDK, entopts map[string]any) GuildWars2Entity

