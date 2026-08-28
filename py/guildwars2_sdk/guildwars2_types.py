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


class AchievementListMatch(TypedDict, total=False):
    ids: str
    v: str


class Authenticated(TypedDict, total=False):
    created: str
    id: str
    name: str
    permissions: list
    subtoken: str
    value: int
    world: int


class AuthenticatedLoadMatch(TypedDict, total=False):
    expire: str
    permission: str
    url: str


class AuthenticatedListMatch(TypedDict, total=False):
    ids: str


class DailyReward(TypedDict):
    pass


class DailyRewardListMatch(TypedDict):
    pass


class GameMechanic(TypedDict):
    pass


class GameMechanicListMatch(TypedDict, total=False):
    ids: str


class Guild(TypedDict, total=False):
    id: str


class GuildLoadMatch(TypedDict):
    id: str


class GuildListMatch(TypedDict, total=False):
    id: str


class GuildAuthenticated(TypedDict, total=False):
    id: str


class GuildAuthenticatedListMatch(TypedDict):
    id: str


class HomeInstance(TypedDict):
    pass


class HomeInstanceListMatch(TypedDict, total=False):
    ids: str


class Item(TypedDict):
    pass


class ItemListMatch(TypedDict, total=False):
    ids: str


class Map(TypedDict):
    pass


class MapListMatch(TypedDict, total=False):
    ids: str


class MapInformation(TypedDict):
    pass


class MapInformationListMatch(TypedDict, total=False):
    ids: str


class Miscellaneous(TypedDict, total=False):
    id: int


class MiscellaneousLoadMatch(TypedDict):
    id: int


class MiscellaneousListMatch(TypedDict, total=False):
    ids: str


class Story(TypedDict):
    pass


class StoryListMatch(TypedDict, total=False):
    ids: str


class StructuredPvP(TypedDict):
    pass


class StructuredPvPListMatch(TypedDict):
    pass


class TradingPost(TypedDict, total=False):
    coins: int
    coins_per_gem: int
    items: list
    quantity: int


class TradingPostLoadMatch(TypedDict):
    quantity: int


class TradingPostListMatch(TypedDict, total=False):
    ids: str


class WorldVsWorld(TypedDict):
    pass


class WorldVsWorldListMatch(TypedDict):
    pass
