# GuildWars2 SDK utility: make_context

from core.context import GuildWars2Context


def make_context_util(ctxmap, basectx):
    return GuildWars2Context(ctxmap, basectx)
