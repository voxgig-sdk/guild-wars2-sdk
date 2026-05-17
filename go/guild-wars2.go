package voxgigguildwars2sdk

import (
	"github.com/voxgig-sdk/guild-wars2-sdk/go/core"
	"github.com/voxgig-sdk/guild-wars2-sdk/go/entity"
	"github.com/voxgig-sdk/guild-wars2-sdk/go/feature"
	_ "github.com/voxgig-sdk/guild-wars2-sdk/go/utility"
)

// Type aliases preserve external API.
type GuildWars2SDK = core.GuildWars2SDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type GuildWars2Entity = core.GuildWars2Entity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type GuildWars2Error = core.GuildWars2Error

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewAchievementEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewAchievementEntity(client, entopts)
	}
	core.NewAuthenticatedEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewAuthenticatedEntity(client, entopts)
	}
	core.NewDailyRewardEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewDailyRewardEntity(client, entopts)
	}
	core.NewGameMechanicEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewGameMechanicEntity(client, entopts)
	}
	core.NewGuildEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewGuildEntity(client, entopts)
	}
	core.NewGuildAuthenticatedEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewGuildAuthenticatedEntity(client, entopts)
	}
	core.NewHomeInstanceEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewHomeInstanceEntity(client, entopts)
	}
	core.NewItemEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewItemEntity(client, entopts)
	}
	core.NewMapEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewMapEntity(client, entopts)
	}
	core.NewMapInformationEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewMapInformationEntity(client, entopts)
	}
	core.NewMiscellaneousEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewMiscellaneousEntity(client, entopts)
	}
	core.NewStoryEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewStoryEntity(client, entopts)
	}
	core.NewStructuredPvPEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewStructuredPvPEntity(client, entopts)
	}
	core.NewTradingPostEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewTradingPostEntity(client, entopts)
	}
	core.NewWorldVsWorldEntityFunc = func(client *core.GuildWars2SDK, entopts map[string]any) core.GuildWars2Entity {
		return entity.NewWorldVsWorldEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewGuildWars2SDK = core.NewGuildWars2SDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
