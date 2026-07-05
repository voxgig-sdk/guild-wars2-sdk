# GuildWars2 SDK

require_relative 'utility/struct/voxgig_struct'
require_relative 'core/utility_type'
require_relative 'core/spec'
require_relative 'core/helpers'

# Load utility registration
require_relative 'utility/register'

# Load config and features
require_relative 'config'
require_relative 'feature/base_feature'
require_relative 'features'

# Load typed models (Struct value objects).
require_relative 'GuildWars2_types'


class GuildWars2SDK
  attr_accessor :mode, :features, :options

  def initialize(options = {})
    @mode = "live"
    @features = []
    @options = nil

    utility = GuildWars2Utility.new
    @_utility = utility

    config = GuildWars2Config.make_config

    @_rootctx = utility.make_context.call({
      "client" => self,
      "utility" => utility,
      "config" => config,
      "options" => options || {},
      "shared" => {},
    }, nil)

    @options = utility.make_options.call(@_rootctx)

    if VoxgigStruct.getpath(@options, "feature.test.active") == true
      @mode = "test"
    end

    @_rootctx.options = @options

    # Add features from config.
    feature_opts = GuildWars2Helpers.to_map(VoxgigStruct.getprop(@options, "feature"))
    if feature_opts
      items = VoxgigStruct.items(feature_opts)
      if items
        items.each do |item|
          fname = item[0]
          fopts = GuildWars2Helpers.to_map(item[1])
          if fopts && fopts["active"] == true
            utility.feature_add.call(@_rootctx, GuildWars2Features.make_feature(fname))
          end
        end
      end
    end

    # Add extension features.
    extend_val = VoxgigStruct.getprop(@options, "extend")
    if extend_val.is_a?(Array)
      extend_val.each do |f|
        if f.respond_to?(:get_name)
          utility.feature_add.call(@_rootctx, f)
        end
      end
    end

    # Initialize features.
    @features.each do |f|
      utility.feature_init.call(@_rootctx, f)
    end

    utility.feature_hook.call(@_rootctx, "PostConstruct")
  end

  def options_map
    out = VoxgigStruct.clone(@options)
    out.is_a?(Hash) ? out : {}
  end

  def get_utility
    GuildWars2Utility.copy(@_utility)
  end

  def get_root_ctx
    @_rootctx
  end

  def prepare(fetchargs = {})
    utility = @_utility
    fetchargs ||= {}

    ctrl = GuildWars2Helpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "prepare",
      "ctrl" => ctrl,
    }, @_rootctx)

    opts = @options
    path = VoxgigStruct.getprop(fetchargs, "path") || ""
    path = "" unless path.is_a?(String)
    method_val = VoxgigStruct.getprop(fetchargs, "method") || "GET"
    method_val = "GET" unless method_val.is_a?(String)
    params = GuildWars2Helpers.to_map(VoxgigStruct.getprop(fetchargs, "params")) || {}
    query = GuildWars2Helpers.to_map(VoxgigStruct.getprop(fetchargs, "query")) || {}
    headers = utility.prepare_headers.call(ctx)

    base = VoxgigStruct.getprop(opts, "base") || ""
    base = "" unless base.is_a?(String)
    prefix = VoxgigStruct.getprop(opts, "prefix") || ""
    prefix = "" unless prefix.is_a?(String)
    suffix = VoxgigStruct.getprop(opts, "suffix") || ""
    suffix = "" unless suffix.is_a?(String)

    ctx.spec = GuildWars2Spec.new({
      "base" => base, "prefix" => prefix, "suffix" => suffix,
      "path" => path, "method" => method_val,
      "params" => params, "query" => query, "headers" => headers,
      "body" => VoxgigStruct.getprop(fetchargs, "body"),
      "step" => "start",
    })

    # Merge user-provided headers.
    uh = VoxgigStruct.getprop(fetchargs, "headers")
    if uh.is_a?(Hash)
      uh.each { |k, v| ctx.spec.headers[k] = v }
    end

    _, err = utility.prepare_auth.call(ctx)
    raise err if err

    # make_fetch_def returns a (fetchdef, err) tuple; destructure it and
    # return just the fetchdef Hash (raising on error) so callers — including
    # direct(), which indexes fetchdef["url"] — receive a Hash, mirroring the
    # ts/py prepare().
    fetchdef, fd_err = utility.make_fetch_def.call(ctx)
    raise fd_err if fd_err

    fetchdef
  end

  def direct(fetchargs = {})
    utility = @_utility

    # direct() is the raw-HTTP escape hatch: it always returns a result hash
    # ({ "ok" => ..., ... }) and never raises. prepare() raises on error, so
    # trap that and surface it in the hash.
    begin
      fetchdef = prepare(fetchargs)
    rescue GuildWars2Error => err
      return { "ok" => false, "err" => err }
    end

    fetchargs ||= {}
    ctrl = GuildWars2Helpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "direct",
      "ctrl" => ctrl,
    }, @_rootctx)

    url = fetchdef["url"] || ""
    fetched, fetch_err = utility.fetcher.call(ctx, url, fetchdef)

    return { "ok" => false, "err" => fetch_err } if fetch_err

    if fetched.nil?
      return {
        "ok" => false,
        "err" => ctx.make_error("direct_no_response", "response: undefined"),
      }
    end

    if fetched.is_a?(Hash)
      status = GuildWars2Helpers.to_int(VoxgigStruct.getprop(fetched, "status"))
      headers = VoxgigStruct.getprop(fetched, "headers") || {}

      # No-body responses (204, 304) and explicit zero content-length must
      # skip JSON parsing — calling json() on an empty body errors.
      content_length = headers.is_a?(Hash) ? headers["content-length"] : nil
      no_body = status == 204 || status == 304 || content_length.to_s == "0"

      json_data = nil
      unless no_body
        jf = VoxgigStruct.getprop(fetched, "json")
        if jf.is_a?(Proc)
          begin
            json_data = jf.call
          rescue StandardError
            # Non-JSON body — leave data nil, keep status/headers.
            json_data = nil
          end
        end
      end

      return {
        "ok" => status >= 200 && status < 300,
        "status" => status,
        "headers" => headers,
        "data" => json_data,
      }
    end

    return {
      "ok" => false,
      "err" => ctx.make_error("direct_invalid", "invalid response type"),
    }
  end


  # Canonical facade: client.Achievement.list / client.Achievement.load({ "id" => ... })
  def Achievement(data = nil)
    require_relative 'entity/achievement_entity'
    AchievementEntity.new(self, data)
  end


  # Canonical facade: client.Authenticated.list / client.Authenticated.load({ "id" => ... })
  def Authenticated(data = nil)
    require_relative 'entity/authenticated_entity'
    AuthenticatedEntity.new(self, data)
  end


  # Canonical facade: client.DailyReward.list / client.DailyReward.load({ "id" => ... })
  def DailyReward(data = nil)
    require_relative 'entity/daily_reward_entity'
    DailyRewardEntity.new(self, data)
  end


  # Canonical facade: client.GameMechanic.list / client.GameMechanic.load({ "id" => ... })
  def GameMechanic(data = nil)
    require_relative 'entity/game_mechanic_entity'
    GameMechanicEntity.new(self, data)
  end


  # Canonical facade: client.Guild.list / client.Guild.load({ "id" => ... })
  def Guild(data = nil)
    require_relative 'entity/guild_entity'
    GuildEntity.new(self, data)
  end


  # Canonical facade: client.GuildAuthenticated.list / client.GuildAuthenticated.load({ "id" => ... })
  def GuildAuthenticated(data = nil)
    require_relative 'entity/guild_authenticated_entity'
    GuildAuthenticatedEntity.new(self, data)
  end


  # Canonical facade: client.HomeInstance.list / client.HomeInstance.load({ "id" => ... })
  def HomeInstance(data = nil)
    require_relative 'entity/home_instance_entity'
    HomeInstanceEntity.new(self, data)
  end


  # Canonical facade: client.Item.list / client.Item.load({ "id" => ... })
  def Item(data = nil)
    require_relative 'entity/item_entity'
    ItemEntity.new(self, data)
  end


  # Canonical facade: client.Map.list / client.Map.load({ "id" => ... })
  def Map(data = nil)
    require_relative 'entity/map_entity'
    MapEntity.new(self, data)
  end


  # Canonical facade: client.MapInformation.list / client.MapInformation.load({ "id" => ... })
  def MapInformation(data = nil)
    require_relative 'entity/map_information_entity'
    MapInformationEntity.new(self, data)
  end


  # Canonical facade: client.Miscellaneous.list / client.Miscellaneous.load({ "id" => ... })
  def Miscellaneous(data = nil)
    require_relative 'entity/miscellaneous_entity'
    MiscellaneousEntity.new(self, data)
  end


  # Canonical facade: client.Story.list / client.Story.load({ "id" => ... })
  def Story(data = nil)
    require_relative 'entity/story_entity'
    StoryEntity.new(self, data)
  end


  # Canonical facade: client.StructuredPvP.list / client.StructuredPvP.load({ "id" => ... })
  def StructuredPvP(data = nil)
    require_relative 'entity/structured_pv_p_entity'
    StructuredPvPEntity.new(self, data)
  end


  # Canonical facade: client.TradingPost.list / client.TradingPost.load({ "id" => ... })
  def TradingPost(data = nil)
    require_relative 'entity/trading_post_entity'
    TradingPostEntity.new(self, data)
  end


  # Canonical facade: client.WorldVsWorld.list / client.WorldVsWorld.load({ "id" => ... })
  def WorldVsWorld(data = nil)
    require_relative 'entity/world_vs_world_entity'
    WorldVsWorldEntity.new(self, data)
  end



  def self.test(testopts = nil, sdkopts = nil)
    sdkopts = sdkopts || {}
    sdkopts = VoxgigStruct.clone(sdkopts)
    sdkopts = {} unless sdkopts.is_a?(Hash)

    testopts = testopts || {}
    testopts = VoxgigStruct.clone(testopts)
    testopts = {} unless testopts.is_a?(Hash)
    testopts["active"] = true

    VoxgigStruct.setpath(sdkopts, "feature.test", testopts)

    sdk = GuildWars2SDK.new(sdkopts)
    sdk.mode = "test"
    sdk
  end
end
