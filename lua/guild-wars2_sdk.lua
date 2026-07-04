-- GuildWars2 SDK

local vs = require("utility.struct.struct")
local Utility = require("core.utility_type")
local Spec = require("core.spec")
local helpers = require("core.helpers")

-- Load utility registration (populates Utility._registrar)
require("utility.register")

-- Load features
local BaseFeature = require("feature.base_feature")
local features_factory = require("features")


local GuildWars2SDK = {}
GuildWars2SDK.__index = GuildWars2SDK


local function _make_feature(name)
  local factory = features_factory[name]
  if factory ~= nil then
    return factory()
  end
  return features_factory.base()
end

GuildWars2SDK._make_feature = _make_feature


function GuildWars2SDK.new(options)
  local self = setmetatable({}, GuildWars2SDK)
  self.mode = "live"
  self.features = {}
  self.options = nil

  local utility = Utility.new()
  self._utility = utility

  local config = require("config")()

  self._rootctx = utility.make_context({
    client = self,
    utility = utility,
    config = config,
    options = options or {},
    shared = {},
  }, nil)

  self.options = utility.make_options(self._rootctx)

  if vs.getpath(self.options, "feature.test.active") == true then
    self.mode = "test"
  end

  self._rootctx.options = self.options

  -- Add features from config.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local feature_items = vs.items(feature_opts)
    if feature_items ~= nil then
      for _, item in ipairs(feature_items) do
        local fname = item[1]
        local fopts = helpers.to_map(item[2])
        if fopts ~= nil and fopts["active"] == true then
          utility.feature_add(self._rootctx, _make_feature(fname))
        end
      end
    end
  end

  -- Add extension features.
  local extend = vs.getprop(self.options, "extend")
  if type(extend) == "table" then
    for _, f in ipairs(extend) do
      if type(f) == "table" and type(f.get_name) == "function" then
        utility.feature_add(self._rootctx, f)
      end
    end
  end

  -- Initialize features.
  for _, f in ipairs(self.features) do
    utility.feature_init(self._rootctx, f)
  end

  utility.feature_hook(self._rootctx, "PostConstruct")

  -- #BuildFeatures

  return self
end


function GuildWars2SDK:options_map()
  local out = vs.clone(self.options)
  if type(out) == "table" then
    return out
  end
  return {}
end


function GuildWars2SDK:get_utility()
  return Utility.copy(self._utility)
end


function GuildWars2SDK:get_root_ctx()
  return self._rootctx
end


function GuildWars2SDK:prepare(fetchargs)
  local utility = self._utility

  fetchargs = fetchargs or {}

  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "prepare",
    ctrl = ctrl,
  }, self._rootctx)

  local options = self.options

  local path = vs.getprop(fetchargs, "path") or ""
  if type(path) ~= "string" then path = "" end

  local method = vs.getprop(fetchargs, "method") or "GET"
  if type(method) ~= "string" then method = "GET" end

  local params = helpers.to_map(vs.getprop(fetchargs, "params")) or {}
  local query = helpers.to_map(vs.getprop(fetchargs, "query")) or {}

  local headers = utility.prepare_headers(ctx)

  local base = vs.getprop(options, "base") or ""
  if type(base) ~= "string" then base = "" end
  local prefix = vs.getprop(options, "prefix") or ""
  if type(prefix) ~= "string" then prefix = "" end
  local suffix = vs.getprop(options, "suffix") or ""
  if type(suffix) ~= "string" then suffix = "" end

  ctx.spec = Spec.new({
    base = base,
    prefix = prefix,
    suffix = suffix,
    path = path,
    method = method,
    params = params,
    query = query,
    headers = headers,
    body = vs.getprop(fetchargs, "body"),
    step = "start",
  })

  -- Merge user-provided headers.
  local uh = vs.getprop(fetchargs, "headers")
  if type(uh) == "table" then
    for k, v in pairs(uh) do
      ctx.spec.headers[k] = v
    end
  end

  local _, err = utility.prepare_auth(ctx)
  if err ~= nil then
    return nil, err
  end

  return utility.make_fetch_def(ctx)
end


function GuildWars2SDK:direct(fetchargs)
  local utility = self._utility

  local fetchdef, err = self:prepare(fetchargs)
  if err ~= nil then
    return { ok = false, err = err }, nil
  end

  fetchargs = fetchargs or {}
  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "direct",
    ctrl = ctrl,
  }, self._rootctx)

  local url = fetchdef["url"] or ""
  local fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

  if fetch_err ~= nil then
    return { ok = false, err = fetch_err }, nil
  end

  if fetched == nil then
    return {
      ok = false,
      err = ctx:make_error("direct_no_response", "response: undefined"),
    }, nil
  end

  if type(fetched) == "table" then
    local status = helpers.to_int(vs.getprop(fetched, "status"))
    local headers = vs.getprop(fetched, "headers") or {}

    -- No-body responses (204, 304) and explicit zero content-length
    -- must skip JSON parsing — calling json() on an empty body errors.
    local content_length = nil
    if type(headers) == "table" then
      content_length = headers["content-length"]
    end
    local no_body = status == 204 or status == 304 or tostring(content_length) == "0"

    local json_data = nil
    if not no_body then
      local jf = vs.getprop(fetched, "json")
      if type(jf) == "function" then
        local ok, result = pcall(jf)
        if ok then
          json_data = result
        end
        -- Non-JSON body: json_data stays nil, status/headers preserved.
      end
    end

    return {
      ok = status >= 200 and status < 300,
      status = status,
      headers = headers,
      data = json_data,
    }, nil
  end

  return {
    ok = false,
    err = ctx:make_error("direct_invalid", "invalid response type"),
  }, nil
end



-- Idiomatic facade: client:achievement():list() / client:achievement():load({ id = ... })
function GuildWars2SDK:achievement(data)
  local EntityMod = require("entity.achievement_entity")
  if data == nil then
    if self._achievement == nil then
      self._achievement = EntityMod.new(self, nil)
    end
    return self._achievement
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:achievement() instead.
function GuildWars2SDK:Achievement(data)
  local EntityMod = require("entity.achievement_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:authenticated():list() / client:authenticated():load({ id = ... })
function GuildWars2SDK:authenticated(data)
  local EntityMod = require("entity.authenticated_entity")
  if data == nil then
    if self._authenticated == nil then
      self._authenticated = EntityMod.new(self, nil)
    end
    return self._authenticated
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:authenticated() instead.
function GuildWars2SDK:Authenticated(data)
  local EntityMod = require("entity.authenticated_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:daily_reward():list() / client:daily_reward():load({ id = ... })
function GuildWars2SDK:daily_reward(data)
  local EntityMod = require("entity.daily_reward_entity")
  if data == nil then
    if self._daily_reward == nil then
      self._daily_reward = EntityMod.new(self, nil)
    end
    return self._daily_reward
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:daily_reward() instead.
function GuildWars2SDK:DailyReward(data)
  local EntityMod = require("entity.daily_reward_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:game_mechanic():list() / client:game_mechanic():load({ id = ... })
function GuildWars2SDK:game_mechanic(data)
  local EntityMod = require("entity.game_mechanic_entity")
  if data == nil then
    if self._game_mechanic == nil then
      self._game_mechanic = EntityMod.new(self, nil)
    end
    return self._game_mechanic
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:game_mechanic() instead.
function GuildWars2SDK:GameMechanic(data)
  local EntityMod = require("entity.game_mechanic_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:guild():list() / client:guild():load({ id = ... })
function GuildWars2SDK:guild(data)
  local EntityMod = require("entity.guild_entity")
  if data == nil then
    if self._guild == nil then
      self._guild = EntityMod.new(self, nil)
    end
    return self._guild
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:guild() instead.
function GuildWars2SDK:Guild(data)
  local EntityMod = require("entity.guild_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:guild_authenticated():list() / client:guild_authenticated():load({ id = ... })
function GuildWars2SDK:guild_authenticated(data)
  local EntityMod = require("entity.guild_authenticated_entity")
  if data == nil then
    if self._guild_authenticated == nil then
      self._guild_authenticated = EntityMod.new(self, nil)
    end
    return self._guild_authenticated
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:guild_authenticated() instead.
function GuildWars2SDK:GuildAuthenticated(data)
  local EntityMod = require("entity.guild_authenticated_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:home_instance():list() / client:home_instance():load({ id = ... })
function GuildWars2SDK:home_instance(data)
  local EntityMod = require("entity.home_instance_entity")
  if data == nil then
    if self._home_instance == nil then
      self._home_instance = EntityMod.new(self, nil)
    end
    return self._home_instance
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:home_instance() instead.
function GuildWars2SDK:HomeInstance(data)
  local EntityMod = require("entity.home_instance_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:item():list() / client:item():load({ id = ... })
function GuildWars2SDK:item(data)
  local EntityMod = require("entity.item_entity")
  if data == nil then
    if self._item == nil then
      self._item = EntityMod.new(self, nil)
    end
    return self._item
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:item() instead.
function GuildWars2SDK:Item(data)
  local EntityMod = require("entity.item_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:map():list() / client:map():load({ id = ... })
function GuildWars2SDK:map(data)
  local EntityMod = require("entity.map_entity")
  if data == nil then
    if self._map == nil then
      self._map = EntityMod.new(self, nil)
    end
    return self._map
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:map() instead.
function GuildWars2SDK:Map(data)
  local EntityMod = require("entity.map_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:map_information():list() / client:map_information():load({ id = ... })
function GuildWars2SDK:map_information(data)
  local EntityMod = require("entity.map_information_entity")
  if data == nil then
    if self._map_information == nil then
      self._map_information = EntityMod.new(self, nil)
    end
    return self._map_information
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:map_information() instead.
function GuildWars2SDK:MapInformation(data)
  local EntityMod = require("entity.map_information_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:miscellaneous():list() / client:miscellaneous():load({ id = ... })
function GuildWars2SDK:miscellaneous(data)
  local EntityMod = require("entity.miscellaneous_entity")
  if data == nil then
    if self._miscellaneous == nil then
      self._miscellaneous = EntityMod.new(self, nil)
    end
    return self._miscellaneous
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:miscellaneous() instead.
function GuildWars2SDK:Miscellaneous(data)
  local EntityMod = require("entity.miscellaneous_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:story():list() / client:story():load({ id = ... })
function GuildWars2SDK:story(data)
  local EntityMod = require("entity.story_entity")
  if data == nil then
    if self._story == nil then
      self._story = EntityMod.new(self, nil)
    end
    return self._story
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:story() instead.
function GuildWars2SDK:Story(data)
  local EntityMod = require("entity.story_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:structured_pv_p():list() / client:structured_pv_p():load({ id = ... })
function GuildWars2SDK:structured_pv_p(data)
  local EntityMod = require("entity.structured_pv_p_entity")
  if data == nil then
    if self._structured_pv_p == nil then
      self._structured_pv_p = EntityMod.new(self, nil)
    end
    return self._structured_pv_p
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:structured_pv_p() instead.
function GuildWars2SDK:StructuredPvP(data)
  local EntityMod = require("entity.structured_pv_p_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:trading_post():list() / client:trading_post():load({ id = ... })
function GuildWars2SDK:trading_post(data)
  local EntityMod = require("entity.trading_post_entity")
  if data == nil then
    if self._trading_post == nil then
      self._trading_post = EntityMod.new(self, nil)
    end
    return self._trading_post
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:trading_post() instead.
function GuildWars2SDK:TradingPost(data)
  local EntityMod = require("entity.trading_post_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:world_vs_world():list() / client:world_vs_world():load({ id = ... })
function GuildWars2SDK:world_vs_world(data)
  local EntityMod = require("entity.world_vs_world_entity")
  if data == nil then
    if self._world_vs_world == nil then
      self._world_vs_world = EntityMod.new(self, nil)
    end
    return self._world_vs_world
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:world_vs_world() instead.
function GuildWars2SDK:WorldVsWorld(data)
  local EntityMod = require("entity.world_vs_world_entity")
  return EntityMod.new(self, data)
end




function GuildWars2SDK.test(testopts, sdkopts)
  sdkopts = sdkopts or {}
  sdkopts = vs.clone(sdkopts)
  if type(sdkopts) ~= "table" then
    sdkopts = {}
  end

  testopts = testopts or {}
  testopts = vs.clone(testopts)
  if type(testopts) ~= "table" then
    testopts = {}
  end
  testopts["active"] = true

  vs.setpath(sdkopts, "feature.test", testopts)

  local sdk = GuildWars2SDK.new(sdkopts)
  sdk.mode = "test"

  return sdk
end


return GuildWars2SDK
