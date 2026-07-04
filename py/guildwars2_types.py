# Typed models for the GuildWars2 SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Achievement(TypedDict):
    pass


class AchievementLoadMatch(TypedDict):
    pass


class AchievementListMatch(TypedDict):
    pass


class Authenticated(TypedDict, total=False):
    created: str
    id: str
    name: str
    permission: list
    subtoken: str
    value: int
    world: int


class AuthenticatedLoadMatch(TypedDict, total=False):
    created: str
    id: str
    name: str
    permission: list
    subtoken: str
    value: int
    world: int


class AuthenticatedListMatch(TypedDict, total=False):
    created: str
    id: str
    name: str
    permission: list
    subtoken: str
    value: int
    world: int


class DailyReward(TypedDict):
    pass


class DailyRewardListMatch(TypedDict):
    pass


class GameMechanic(TypedDict):
    pass


class GameMechanicListMatch(TypedDict):
    pass


class Guild(TypedDict):
    pass


class GuildLoadMatch(TypedDict):
    id: str


class GuildListMatch(TypedDict):
    pass


class GuildAuthenticated(TypedDict):
    pass


class GuildAuthenticatedListMatch(TypedDict):
    id: str


class HomeInstance(TypedDict):
    pass


class HomeInstanceListMatch(TypedDict):
    pass


class Item(TypedDict):
    pass


class ItemListMatch(TypedDict):
    pass


class Map(TypedDict):
    pass


class MapListMatch(TypedDict):
    pass


class MapInformation(TypedDict):
    pass


class MapInformationListMatch(TypedDict):
    pass


class Miscellaneous(TypedDict, total=False):
    id: int


class MiscellaneousLoadMatch(TypedDict, total=False):
    id: int


class MiscellaneousListMatch(TypedDict, total=False):
    id: int


class Story(TypedDict):
    pass


class StoryListMatch(TypedDict):
    pass


class StructuredPvP(TypedDict):
    pass


class StructuredPvPListMatch(TypedDict):
    pass


class TradingPost(TypedDict, total=False):
    coin: int
    coins_per_gem: int
    item: list
    quantity: int


class TradingPostLoadMatch(TypedDict, total=False):
    coin: int
    coins_per_gem: int
    item: list
    quantity: int


class TradingPostListMatch(TypedDict, total=False):
    coin: int
    coins_per_gem: int
    item: list
    quantity: int


class WorldVsWorld(TypedDict):
    pass


class WorldVsWorldListMatch(TypedDict):
    pass
