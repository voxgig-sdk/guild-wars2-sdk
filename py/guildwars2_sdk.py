# GuildWars2 SDK

from utility.voxgig_struct import voxgig_struct as vs
from core.utility_type import GuildWars2Utility
from core.spec import GuildWars2Spec
from core import helpers

# Load utility registration (populates Utility._registrar)
from utility import register

# Load features
from feature.base_feature import GuildWars2BaseFeature
from features import _make_feature


class GuildWars2SDK:

    def __init__(self, options=None):
        self.mode = "live"
        self.features = []
        self.options = None

        utility = GuildWars2Utility()
        self._utility = utility

        from config import make_config
        config = make_config()

        self._rootctx = utility.make_context({
            "client": self,
            "utility": utility,
            "config": config,
            "options": options if options is not None else {},
            "shared": {},
        }, None)

        self.options = utility.make_options(self._rootctx)

        if vs.getpath(self.options, "feature.test.active") is True:
            self.mode = "test"

        self._rootctx.options = self.options

        # Add features from config.
        feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
        if feature_opts is not None:
            feature_items = vs.items(feature_opts)
            if feature_items is not None:
                for item in feature_items:
                    fname = item[0]
                    fopts = helpers.to_map(item[1])
                    if fopts is not None and fopts.get("active") is True:
                        utility.feature_add(self._rootctx, _make_feature(fname))

        # Add extension features.
        extend = vs.getprop(self.options, "extend")
        if isinstance(extend, list):
            for f in extend:
                if isinstance(f, dict) or (hasattr(f, "get_name") and callable(f.get_name)):
                    utility.feature_add(self._rootctx, f)

        # Initialize features.
        for f in self.features:
            utility.feature_init(self._rootctx, f)

        utility.feature_hook(self._rootctx, "PostConstruct")

        # #BuildFeatures

    def options_map(self):
        out = vs.clone(self.options)
        if isinstance(out, dict):
            return out
        return {}

    def get_utility(self):
        return GuildWars2Utility.copy(self._utility)

    def get_root_ctx(self):
        return self._rootctx

    def prepare(self, fetchargs=None):
        utility = self._utility

        if fetchargs is None:
            fetchargs = {}

        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "prepare",
            "ctrl": ctrl,
        }, self._rootctx)

        options = self.options

        path = vs.getprop(fetchargs, "path") or ""
        if not isinstance(path, str):
            path = ""

        method = vs.getprop(fetchargs, "method") or "GET"
        if not isinstance(method, str):
            method = "GET"

        params = helpers.to_map(vs.getprop(fetchargs, "params"))
        if params is None:
            params = {}
        query = helpers.to_map(vs.getprop(fetchargs, "query"))
        if query is None:
            query = {}

        headers = utility.prepare_headers(ctx)

        base = vs.getprop(options, "base") or ""
        if not isinstance(base, str):
            base = ""
        prefix = vs.getprop(options, "prefix") or ""
        if not isinstance(prefix, str):
            prefix = ""
        suffix = vs.getprop(options, "suffix") or ""
        if not isinstance(suffix, str):
            suffix = ""

        ctx.spec = GuildWars2Spec({
            "base": base,
            "prefix": prefix,
            "suffix": suffix,
            "path": path,
            "method": method,
            "params": params,
            "query": query,
            "headers": headers,
            "body": vs.getprop(fetchargs, "body"),
            "step": "start",
        })

        # Merge user-provided headers.
        uh = vs.getprop(fetchargs, "headers")
        if isinstance(uh, dict):
            for k, v in uh.items():
                ctx.spec.headers[k] = v

        _, err = utility.prepare_auth(ctx)
        if err is not None:
            raise err

        fetchdef, err = utility.make_fetch_def(ctx)
        if err is not None:
            raise err

        return fetchdef

    def direct(self, fetchargs=None):
        utility = self._utility

        try:
            fetchdef = self.prepare(fetchargs)
        except Exception as err:
            # direct() is the raw-HTTP escape hatch: it never raises, it
            # returns a result object callers branch on via result["ok"].
            return {"ok": False, "err": err}

        if fetchargs is None:
            fetchargs = {}
        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "direct",
            "ctrl": ctrl,
        }, self._rootctx)

        url = fetchdef.get("url", "")
        fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

        if fetch_err is not None:
            return {"ok": False, "err": fetch_err}

        if fetched is None:
            return {
                "ok": False,
                "err": ctx.make_error("direct_no_response", "response: undefined"),
            }

        if isinstance(fetched, dict):
            status = helpers.to_int(vs.getprop(fetched, "status"))
            headers = vs.getprop(fetched, "headers") or {}

            # No-body responses (204, 304) and explicit zero content-length
            # must skip JSON parsing — calling json() on an empty body raises.
            content_length = None
            if isinstance(headers, dict):
                content_length = headers.get("content-length")
            no_body = status in (204, 304) or str(content_length) == "0"

            json_data = None
            if not no_body:
                jf = vs.getprop(fetched, "json")
                if callable(jf):
                    try:
                        json_data = jf()
                    except Exception:
                        # Non-JSON body (e.g. text/plain, text/html). Surface
                        # status + headers but leave data as None.
                        json_data = None

            return {
                "ok": status >= 200 and status < 300,
                "status": status,
                "headers": headers,
                "data": json_data,
            }

        return {
            "ok": False,
            "err": ctx.make_error("direct_invalid", "invalid response type"),
        }


    @property
    def achievement(self):
        """Idiomatic facade: client.achievement.list() / client.achievement.load({"id": ...})."""
        from entity.achievement_entity import AchievementEntity
        cached = getattr(self, "_achievement", None)
        if cached is None:
            cached = AchievementEntity(self, None)
            self._achievement = cached
        return cached

    def Achievement(self, data=None):
        # Deprecated: use client.achievement instead.
        from entity.achievement_entity import AchievementEntity
        return AchievementEntity(self, data)


    @property
    def authenticated(self):
        """Idiomatic facade: client.authenticated.list() / client.authenticated.load({"id": ...})."""
        from entity.authenticated_entity import AuthenticatedEntity
        cached = getattr(self, "_authenticated", None)
        if cached is None:
            cached = AuthenticatedEntity(self, None)
            self._authenticated = cached
        return cached

    def Authenticated(self, data=None):
        # Deprecated: use client.authenticated instead.
        from entity.authenticated_entity import AuthenticatedEntity
        return AuthenticatedEntity(self, data)


    @property
    def daily_reward(self):
        """Idiomatic facade: client.daily_reward.list() / client.daily_reward.load({"id": ...})."""
        from entity.daily_reward_entity import DailyRewardEntity
        cached = getattr(self, "_daily_reward", None)
        if cached is None:
            cached = DailyRewardEntity(self, None)
            self._daily_reward = cached
        return cached

    def DailyReward(self, data=None):
        # Deprecated: use client.daily_reward instead.
        from entity.daily_reward_entity import DailyRewardEntity
        return DailyRewardEntity(self, data)


    @property
    def game_mechanic(self):
        """Idiomatic facade: client.game_mechanic.list() / client.game_mechanic.load({"id": ...})."""
        from entity.game_mechanic_entity import GameMechanicEntity
        cached = getattr(self, "_game_mechanic", None)
        if cached is None:
            cached = GameMechanicEntity(self, None)
            self._game_mechanic = cached
        return cached

    def GameMechanic(self, data=None):
        # Deprecated: use client.game_mechanic instead.
        from entity.game_mechanic_entity import GameMechanicEntity
        return GameMechanicEntity(self, data)


    @property
    def guild(self):
        """Idiomatic facade: client.guild.list() / client.guild.load({"id": ...})."""
        from entity.guild_entity import GuildEntity
        cached = getattr(self, "_guild", None)
        if cached is None:
            cached = GuildEntity(self, None)
            self._guild = cached
        return cached

    def Guild(self, data=None):
        # Deprecated: use client.guild instead.
        from entity.guild_entity import GuildEntity
        return GuildEntity(self, data)


    @property
    def guild_authenticated(self):
        """Idiomatic facade: client.guild_authenticated.list() / client.guild_authenticated.load({"id": ...})."""
        from entity.guild_authenticated_entity import GuildAuthenticatedEntity
        cached = getattr(self, "_guild_authenticated", None)
        if cached is None:
            cached = GuildAuthenticatedEntity(self, None)
            self._guild_authenticated = cached
        return cached

    def GuildAuthenticated(self, data=None):
        # Deprecated: use client.guild_authenticated instead.
        from entity.guild_authenticated_entity import GuildAuthenticatedEntity
        return GuildAuthenticatedEntity(self, data)


    @property
    def home_instance(self):
        """Idiomatic facade: client.home_instance.list() / client.home_instance.load({"id": ...})."""
        from entity.home_instance_entity import HomeInstanceEntity
        cached = getattr(self, "_home_instance", None)
        if cached is None:
            cached = HomeInstanceEntity(self, None)
            self._home_instance = cached
        return cached

    def HomeInstance(self, data=None):
        # Deprecated: use client.home_instance instead.
        from entity.home_instance_entity import HomeInstanceEntity
        return HomeInstanceEntity(self, data)


    @property
    def item(self):
        """Idiomatic facade: client.item.list() / client.item.load({"id": ...})."""
        from entity.item_entity import ItemEntity
        cached = getattr(self, "_item", None)
        if cached is None:
            cached = ItemEntity(self, None)
            self._item = cached
        return cached

    def Item(self, data=None):
        # Deprecated: use client.item instead.
        from entity.item_entity import ItemEntity
        return ItemEntity(self, data)


    @property
    def map(self):
        """Idiomatic facade: client.map.list() / client.map.load({"id": ...})."""
        from entity.map_entity import MapEntity
        cached = getattr(self, "_map", None)
        if cached is None:
            cached = MapEntity(self, None)
            self._map = cached
        return cached

    def Map(self, data=None):
        # Deprecated: use client.map instead.
        from entity.map_entity import MapEntity
        return MapEntity(self, data)


    @property
    def map_information(self):
        """Idiomatic facade: client.map_information.list() / client.map_information.load({"id": ...})."""
        from entity.map_information_entity import MapInformationEntity
        cached = getattr(self, "_map_information", None)
        if cached is None:
            cached = MapInformationEntity(self, None)
            self._map_information = cached
        return cached

    def MapInformation(self, data=None):
        # Deprecated: use client.map_information instead.
        from entity.map_information_entity import MapInformationEntity
        return MapInformationEntity(self, data)


    @property
    def miscellaneous(self):
        """Idiomatic facade: client.miscellaneous.list() / client.miscellaneous.load({"id": ...})."""
        from entity.miscellaneous_entity import MiscellaneousEntity
        cached = getattr(self, "_miscellaneous", None)
        if cached is None:
            cached = MiscellaneousEntity(self, None)
            self._miscellaneous = cached
        return cached

    def Miscellaneous(self, data=None):
        # Deprecated: use client.miscellaneous instead.
        from entity.miscellaneous_entity import MiscellaneousEntity
        return MiscellaneousEntity(self, data)


    @property
    def story(self):
        """Idiomatic facade: client.story.list() / client.story.load({"id": ...})."""
        from entity.story_entity import StoryEntity
        cached = getattr(self, "_story", None)
        if cached is None:
            cached = StoryEntity(self, None)
            self._story = cached
        return cached

    def Story(self, data=None):
        # Deprecated: use client.story instead.
        from entity.story_entity import StoryEntity
        return StoryEntity(self, data)


    @property
    def structured_pv_p(self):
        """Idiomatic facade: client.structured_pv_p.list() / client.structured_pv_p.load({"id": ...})."""
        from entity.structured_pv_p_entity import StructuredPvPEntity
        cached = getattr(self, "_structured_pv_p", None)
        if cached is None:
            cached = StructuredPvPEntity(self, None)
            self._structured_pv_p = cached
        return cached

    def StructuredPvP(self, data=None):
        # Deprecated: use client.structured_pv_p instead.
        from entity.structured_pv_p_entity import StructuredPvPEntity
        return StructuredPvPEntity(self, data)


    @property
    def trading_post(self):
        """Idiomatic facade: client.trading_post.list() / client.trading_post.load({"id": ...})."""
        from entity.trading_post_entity import TradingPostEntity
        cached = getattr(self, "_trading_post", None)
        if cached is None:
            cached = TradingPostEntity(self, None)
            self._trading_post = cached
        return cached

    def TradingPost(self, data=None):
        # Deprecated: use client.trading_post instead.
        from entity.trading_post_entity import TradingPostEntity
        return TradingPostEntity(self, data)


    @property
    def world_vs_world(self):
        """Idiomatic facade: client.world_vs_world.list() / client.world_vs_world.load({"id": ...})."""
        from entity.world_vs_world_entity import WorldVsWorldEntity
        cached = getattr(self, "_world_vs_world", None)
        if cached is None:
            cached = WorldVsWorldEntity(self, None)
            self._world_vs_world = cached
        return cached

    def WorldVsWorld(self, data=None):
        # Deprecated: use client.world_vs_world instead.
        from entity.world_vs_world_entity import WorldVsWorldEntity
        return WorldVsWorldEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None):
        if sdkopts is None:
            sdkopts = {}
        sdkopts = vs.clone(sdkopts)
        if not isinstance(sdkopts, dict):
            sdkopts = {}

        if testopts is None:
            testopts = {}
        testopts = vs.clone(testopts)
        if not isinstance(testopts, dict):
            testopts = {}
        testopts["active"] = True

        vs.setpath(sdkopts, "feature.test", testopts)

        sdk = cls(sdkopts)
        sdk.mode = "test"

        return sdk
