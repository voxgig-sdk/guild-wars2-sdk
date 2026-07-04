# Typed models for the GuildWars2 SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Achievement:
    pass


@dataclass
class AchievementLoadMatch:
    pass


@dataclass
class AchievementListMatch:
    pass


@dataclass
class Authenticated:
    created: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    permission: Optional[list] = None
    subtoken: Optional[str] = None
    value: Optional[int] = None
    world: Optional[int] = None


@dataclass
class AuthenticatedLoadMatch:
    created: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    permission: Optional[list] = None
    subtoken: Optional[str] = None
    value: Optional[int] = None
    world: Optional[int] = None


@dataclass
class AuthenticatedListMatch:
    created: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    permission: Optional[list] = None
    subtoken: Optional[str] = None
    value: Optional[int] = None
    world: Optional[int] = None


@dataclass
class DailyReward:
    pass


@dataclass
class DailyRewardListMatch:
    pass


@dataclass
class GameMechanic:
    pass


@dataclass
class GameMechanicListMatch:
    pass


@dataclass
class Guild:
    pass


@dataclass
class GuildLoadMatch:
    id: str


@dataclass
class GuildListMatch:
    pass


@dataclass
class GuildAuthenticated:
    pass


@dataclass
class GuildAuthenticatedListMatch:
    id: str


@dataclass
class HomeInstance:
    pass


@dataclass
class HomeInstanceListMatch:
    pass


@dataclass
class Item:
    pass


@dataclass
class ItemListMatch:
    pass


@dataclass
class Map:
    pass


@dataclass
class MapListMatch:
    pass


@dataclass
class MapInformation:
    pass


@dataclass
class MapInformationListMatch:
    pass


@dataclass
class Miscellaneous:
    id: Optional[int] = None


@dataclass
class MiscellaneousLoadMatch:
    id: Optional[int] = None


@dataclass
class MiscellaneousListMatch:
    id: Optional[int] = None


@dataclass
class Story:
    pass


@dataclass
class StoryListMatch:
    pass


@dataclass
class StructuredPvP:
    pass


@dataclass
class StructuredPvPListMatch:
    pass


@dataclass
class TradingPost:
    coin: Optional[int] = None
    coins_per_gem: Optional[int] = None
    item: Optional[list] = None
    quantity: Optional[int] = None


@dataclass
class TradingPostLoadMatch:
    coin: Optional[int] = None
    coins_per_gem: Optional[int] = None
    item: Optional[list] = None
    quantity: Optional[int] = None


@dataclass
class TradingPostListMatch:
    coin: Optional[int] = None
    coins_per_gem: Optional[int] = None
    item: Optional[list] = None
    quantity: Optional[int] = None


@dataclass
class WorldVsWorld:
    pass


@dataclass
class WorldVsWorldListMatch:
    pass

