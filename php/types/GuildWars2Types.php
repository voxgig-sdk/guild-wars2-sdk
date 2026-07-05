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

/** Request payload for Achievement#load. */
class AchievementLoadMatch
{
}

/** Request payload for Achievement#list. */
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

/** Request payload for Authenticated#load. */
class AuthenticatedLoadMatch
{
    public ?string $created = null;
    public string $id;
    public ?string $name = null;
    public ?array $permission = null;
    public ?string $subtoken = null;
    public ?int $value = null;
    public ?int $world = null;
}

/** Request payload for Authenticated#list. */
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

/** Request payload for DailyReward#list. */
class DailyRewardListMatch
{
}

/** GameMechanic entity data model. */
class GameMechanic
{
}

/** Request payload for GameMechanic#list. */
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

/** Request payload for Guild#list. */
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

/** Request payload for HomeInstance#list. */
class HomeInstanceListMatch
{
}

/** Item entity data model. */
class Item
{
}

/** Request payload for Item#list. */
class ItemListMatch
{
}

/** Map entity data model. */
class Map
{
}

/** Request payload for Map#list. */
class MapListMatch
{
}

/** MapInformation entity data model. */
class MapInformation
{
}

/** Request payload for MapInformation#list. */
class MapInformationListMatch
{
}

/** Miscellaneous entity data model. */
class Miscellaneous
{
    public ?int $id = null;
}

/** Request payload for Miscellaneous#load. */
class MiscellaneousLoadMatch
{
    public int $id;
}

/** Request payload for Miscellaneous#list. */
class MiscellaneousListMatch
{
    public ?int $id = null;
}

/** Story entity data model. */
class Story
{
}

/** Request payload for Story#list. */
class StoryListMatch
{
}

/** StructuredPvP entity data model. */
class StructuredPvP
{
}

/** Request payload for StructuredPvP#list. */
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

/** Request payload for TradingPost#load. */
class TradingPostLoadMatch
{
    public ?int $coin = null;
    public ?int $coins_per_gem = null;
    public ?array $item = null;
    public ?int $quantity = null;
}

/** Request payload for TradingPost#list. */
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

/** Request payload for WorldVsWorld#list. */
class WorldVsWorldListMatch
{
}

