// Typed models for the GuildWars2 SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import (
	"encoding/json"

	"github.com/voxgig-sdk/guild-wars2-sdk/go/core"
)

// Achievement is the typed data model for the achievement entity.
type Achievement struct {
}

// AchievementLoadMatch is the typed request payload for Achievement.LoadTyped.
type AchievementLoadMatch struct {
}

// AchievementListMatch is the typed request payload for Achievement.ListTyped.
type AchievementListMatch struct {
	Ids *string `json:"ids,omitempty"`
	V *string `json:"v,omitempty"`
}

// Authenticated is the typed data model for the authenticated entity.
type Authenticated struct {
	Created *string `json:"created,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Permissions *[]any `json:"permissions,omitempty"`
	Subtoken *string `json:"subtoken,omitempty"`
	Value *int `json:"value,omitempty"`
	World *int `json:"world,omitempty"`
}

// AuthenticatedLoadMatch is the typed request payload for Authenticated.LoadTyped.
type AuthenticatedLoadMatch struct {
	Expire *string `json:"expire,omitempty"`
	Permission *string `json:"permission,omitempty"`
	Url *string `json:"url,omitempty"`
}

// AuthenticatedListMatch is the typed request payload for Authenticated.ListTyped.
type AuthenticatedListMatch struct {
	Ids *string `json:"ids,omitempty"`
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
	Ids *string `json:"ids,omitempty"`
}

// Guild is the typed data model for the guild entity.
type Guild struct {
	Id *string `json:"id,omitempty"`
}

// GuildLoadMatch is the typed request payload for Guild.LoadTyped.
type GuildLoadMatch struct {
	Id string `json:"id"`
}

// GuildListMatch is the typed request payload for Guild.ListTyped.
type GuildListMatch struct {
	Id *string `json:"id,omitempty"`
}

// GuildAuthenticated is the typed data model for the guild_authenticated entity.
type GuildAuthenticated struct {
	Id *string `json:"id,omitempty"`
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
	Ids *string `json:"ids,omitempty"`
}

// Item is the typed data model for the item entity.
type Item struct {
}

// ItemListMatch is the typed request payload for Item.ListTyped.
type ItemListMatch struct {
	Ids *string `json:"ids,omitempty"`
}

// Map is the typed data model for the map entity.
type Map struct {
}

// MapListMatch is the typed request payload for Map.ListTyped.
type MapListMatch struct {
	Ids *string `json:"ids,omitempty"`
}

// MapInformation is the typed data model for the map_information entity.
type MapInformation struct {
}

// MapInformationListMatch is the typed request payload for MapInformation.ListTyped.
type MapInformationListMatch struct {
	Ids *string `json:"ids,omitempty"`
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
	Ids *string `json:"ids,omitempty"`
}

// Story is the typed data model for the story entity.
type Story struct {
}

// StoryListMatch is the typed request payload for Story.ListTyped.
type StoryListMatch struct {
	Ids *string `json:"ids,omitempty"`
}

// StructuredPvP is the typed data model for the structured_pv_p entity.
type StructuredPvP struct {
}

// StructuredPvPListMatch is the typed request payload for StructuredPvP.ListTyped.
type StructuredPvPListMatch struct {
}

// TradingPost is the typed data model for the trading_post entity.
type TradingPost struct {
	Coins *int `json:"coins,omitempty"`
	CoinsPerGem *int `json:"coins_per_gem,omitempty"`
	Items *[]any `json:"items,omitempty"`
	Quantity *int `json:"quantity,omitempty"`
}

// TradingPostLoadMatch is the typed request payload for TradingPost.LoadTyped.
type TradingPostLoadMatch struct {
	Quantity int `json:"quantity"`
}

// TradingPostListMatch is the typed request payload for TradingPost.ListTyped.
type TradingPostListMatch struct {
	Ids *string `json:"ids,omitempty"`
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

// entityData unwraps an entity to its data map.
//
// Operations resolve to the ENTITY, not the raw data (see AGENTS.md), and an
// entity's fields are UNEXPORTED — marshalling one directly yields `{}`, so
// every typed accessor would silently hand back a zero-valued struct. The
// typed boundary therefore takes the data hop first.
func entityData(v any) any {
	if ent, ok := v.(core.Entity); ok {
		return ent.Data()
	}
	return v
}

// typedFrom decodes a runtime value (an entity, or the map[string]any the op
// pipeline produced) into a typed model T via a JSON round-trip. On any error
// it returns the zero value of T; the op's own (value, error) tuple carries
// the real error.
func typedFrom[T any](v any) T {
	var out T
	v = entityData(v)
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

// typedSliceFrom decodes a runtime list value into a typed slice []T via a
// JSON round-trip, for list ops. `list` resolves to a slice of ENTITY
// instances, so each element takes the data hop.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	if list, ok := v.([]any); ok {
		unwrapped := make([]any, 0, len(list))
		for _, item := range list {
			unwrapped = append(unwrapped, entityData(item))
		}
		v = unwrapped
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
