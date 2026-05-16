# ProjectName SDK exists test

import pytest
from guildwars2_sdk import GuildWars2SDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = GuildWars2SDK.test(None, None)
        assert testsdk is not None
