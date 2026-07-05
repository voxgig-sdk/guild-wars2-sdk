// Typed models for the GuildWars2 SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Achievement is the typed data model for the achievement entity.
type Achievement struct {
}

// AchievementLoadMatch is the typed request payload for Achievement.LoadTyped.
type AchievementLoadMatch struct {
}

// AchievementListMatch is the typed request payload for Achievement.ListTyped.
type AchievementListMatch struct {
}

// Authenticated is the typed data model for the authenticated entity.
type Authenticated struct {
	Created *string `json:"created,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Permission *[]any `json:"permission,omitempty"`
	Subtoken *string `json:"subtoken,omitempty"`
	Value *int `json:"value,omitempty"`
	World *int `json:"world,omitempty"`
}

// AuthenticatedLoadMatch is the typed request payload for Authenticated.LoadTyped.
type AuthenticatedLoadMatch struct {
	Created *string `json:"created,omitempty"`
	Id string `json:"id"`
	Name *string `json:"name,omitempty"`
	Permission *[]any `json:"permission,omitempty"`
	Subtoken *string `json:"subtoken,omitempty"`
	Value *int `json:"value,omitempty"`
	World *int `json:"world,omitempty"`
}

// AuthenticatedListMatch is the typed request payload for Authenticated.ListTyped.
type AuthenticatedListMatch struct {
	Created *string `json:"created,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Permission *[]any `json:"permission,omitempty"`
	Subtoken *string `json:"subtoken,omitempty"`
	Value *int `json:"value,omitempty"`
	World *int `json:"world,omitempty"`
}

// DailyReward is the typed data model for the daily_reward entity.
type DailyReward struct {
}

// DailyRewardListMatch is the typed request payload for DailyReward.ListTyped.
type DailyRewardListMatch struct {
}

// GameMechanic is the typed data model for the game_mechanic entity.
type GameMechanic struct {
}

// GameMechanicListMatch is the typed request payload for GameMechanic.ListTyped.
type GameMechanicListMatch struct {
}

// Guild is the typed data model for the guild entity.
type Guild struct {
}

// GuildLoadMatch is the typed request payload for Guild.LoadTyped.
type GuildLoadMatch struct {
	Id string `json:"id"`
}

// GuildListMatch is the typed request payload for Guild.ListTyped.
type GuildListMatch struct {
}

// GuildAuthenticated is the typed data model for the guild_authenticated entity.
type GuildAuthenticated struct {
}

// GuildAuthenticatedListMatch is the typed request payload for GuildAuthenticated.ListTyped.
type GuildAuthenticatedListMatch struct {
	Id string `json:"id"`
}

// HomeInstance is the typed data model for the home_instance entity.
type HomeInstance struct {
}

// HomeInstanceListMatch is the typed request payload for HomeInstance.ListTyped.
type HomeInstanceListMatch struct {
}

// Item is the typed data model for the item entity.
type Item struct {
}

// ItemListMatch is the typed request payload for Item.ListTyped.
type ItemListMatch struct {
}

// Map is the typed data model for the map entity.
type Map struct {
}

// MapListMatch is the typed request payload for Map.ListTyped.
type MapListMatch struct {
}

// MapInformation is the typed data model for the map_information entity.
type MapInformation struct {
}

// MapInformationListMatch is the typed request payload for MapInformation.ListTyped.
type MapInformationListMatch struct {
}

// Miscellaneous is the typed data model for the miscellaneous entity.
type Miscellaneous struct {
	Id *int `json:"id,omitempty"`
}

// MiscellaneousLoadMatch is the typed request payload for Miscellaneous.LoadTyped.
type MiscellaneousLoadMatch struct {
	Id int `json:"id"`
}

// MiscellaneousListMatch is the typed request payload for Miscellaneous.ListTyped.
type MiscellaneousListMatch struct {
	Id *int `json:"id,omitempty"`
}

// Story is the typed data model for the story entity.
type Story struct {
}

// StoryListMatch is the typed request payload for Story.ListTyped.
type StoryListMatch struct {
}

// StructuredPvP is the typed data model for the structured_pv_p entity.
type StructuredPvP struct {
}

// StructuredPvPListMatch is the typed request payload for StructuredPvP.ListTyped.
type StructuredPvPListMatch struct {
}

// TradingPost is the typed data model for the trading_post entity.
type TradingPost struct {
	Coin *int `json:"coin,omitempty"`
	CoinsPerGem *int `json:"coins_per_gem,omitempty"`
	Item *[]any `json:"item,omitempty"`
	Quantity *int `json:"quantity,omitempty"`
}

// TradingPostLoadMatch is the typed request payload for TradingPost.LoadTyped.
type TradingPostLoadMatch struct {
	Coin *int `json:"coin,omitempty"`
	CoinsPerGem *int `json:"coins_per_gem,omitempty"`
	Item *[]any `json:"item,omitempty"`
	Quantity *int `json:"quantity,omitempty"`
}

// TradingPostListMatch is the typed request payload for TradingPost.ListTyped.
type TradingPostListMatch struct {
	Coin *int `json:"coin,omitempty"`
	CoinsPerGem *int `json:"coins_per_gem,omitempty"`
	Item *[]any `json:"item,omitempty"`
	Quantity *int `json:"quantity,omitempty"`
}

// WorldVsWorld is the typed data model for the world_vs_world entity.
type WorldVsWorld struct {
}

// WorldVsWorldListMatch is the typed request payload for WorldVsWorld.ListTyped.
type WorldVsWorldListMatch struct {
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
