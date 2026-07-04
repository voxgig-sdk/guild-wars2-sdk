<?php
declare(strict_types=1);

// Typed models for the GuildWars2 SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Achievement entity data model. */
class Achievement
{
}

/** Match filter for Achievement#load (any subset of Achievement fields). */
class AchievementLoadMatch
{
}

/** Match filter for Achievement#list (any subset of Achievement fields). */
class AchievementListMatch
{
}

/** Authenticated entity data model. */
class Authenticated
{
    public ?string $created = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?array $permission = null;
    public ?string $subtoken = null;
    public ?int $value = null;
    public ?int $world = null;
}

/** Match filter for Authenticated#load (any subset of Authenticated fields). */
class AuthenticatedLoadMatch
{
    public ?string $created = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?array $permission = null;
    public ?string $subtoken = null;
    public ?int $value = null;
    public ?int $world = null;
}

/** Match filter for Authenticated#list (any subset of Authenticated fields). */
class AuthenticatedListMatch
{
    public ?string $created = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?array $permission = null;
    public ?string $subtoken = null;
    public ?int $value = null;
    public ?int $world = null;
}

/** DailyReward entity data model. */
class DailyReward
{
}

/** Match filter for DailyReward#list (any subset of DailyReward fields). */
class DailyRewardListMatch
{
}

/** GameMechanic entity data model. */
class GameMechanic
{
}

/** Match filter for GameMechanic#list (any subset of GameMechanic fields). */
class GameMechanicListMatch
{
}

/** Guild entity data model. */
class Guild
{
}

/** Request payload for Guild#load. */
class GuildLoadMatch
{
    public string $id;
}

/** Match filter for Guild#list (any subset of Guild fields). */
class GuildListMatch
{
}

/** GuildAuthenticated entity data model. */
class GuildAuthenticated
{
}

/** Request payload for GuildAuthenticated#list. */
class GuildAuthenticatedListMatch
{
    public string $id;
}

/** HomeInstance entity data model. */
class HomeInstance
{
}

/** Match filter for HomeInstance#list (any subset of HomeInstance fields). */
class HomeInstanceListMatch
{
}

/** Item entity data model. */
class Item
{
}

/** Match filter for Item#list (any subset of Item fields). */
class ItemListMatch
{
}

/** Map entity data model. */
class Map
{
}

/** Match filter for Map#list (any subset of Map fields). */
class MapListMatch
{
}

/** MapInformation entity data model. */
class MapInformation
{
}

/** Match filter for MapInformation#list (any subset of MapInformation fields). */
class MapInformationListMatch
{
}

/** Miscellaneous entity data model. */
class Miscellaneous
{
    public ?int $id = null;
}

/** Match filter for Miscellaneous#load (any subset of Miscellaneous fields). */
class MiscellaneousLoadMatch
{
    public ?int $id = null;
}

/** Match filter for Miscellaneous#list (any subset of Miscellaneous fields). */
class MiscellaneousListMatch
{
    public ?int $id = null;
}

/** Story entity data model. */
class Story
{
}

/** Match filter for Story#list (any subset of Story fields). */
class StoryListMatch
{
}

/** StructuredPvP entity data model. */
class StructuredPvP
{
}

/** Match filter for StructuredPvP#list (any subset of StructuredPvP fields). */
class StructuredPvPListMatch
{
}

/** TradingPost entity data model. */
class TradingPost
{
    public ?int $coin = null;
    public ?int $coins_per_gem = null;
    public ?array $item = null;
    public ?int $quantity = null;
}

/** Match filter for TradingPost#load (any subset of TradingPost fields). */
class TradingPostLoadMatch
{
    public ?int $coin = null;
    public ?int $coins_per_gem = null;
    public ?array $item = null;
    public ?int $quantity = null;
}

/** Match filter for TradingPost#list (any subset of TradingPost fields). */
class TradingPostListMatch
{
    public ?int $coin = null;
    public ?int $coins_per_gem = null;
    public ?array $item = null;
    public ?int $quantity = null;
}

/** WorldVsWorld entity data model. */
class WorldVsWorld
{
}

/** Match filter for WorldVsWorld#list (any subset of WorldVsWorld fields). */
class WorldVsWorldListMatch
{
}

