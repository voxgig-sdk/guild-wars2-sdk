# GuildWars2 SDK feature factory

from feature.base_feature import GuildWars2BaseFeature
from feature.test_feature import GuildWars2TestFeature


def _make_feature(name):
    features = {
        "base": lambda: GuildWars2BaseFeature(),
        "test": lambda: GuildWars2TestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
