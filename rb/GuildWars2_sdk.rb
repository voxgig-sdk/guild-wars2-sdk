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

    utility.make_fetch_def.call(ctx)
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


  # Idiomatic facade: client.achievement.list / client.achievement.load({ "id" => ... })
  def achievement
    require_relative 'entity/achievement_entity'
    @achievement ||= AchievementEntity.new(self, nil)
  end

  # Deprecated: use client.achievement instead.
  def Achievement(data = nil)
    require_relative 'entity/achievement_entity'
    AchievementEntity.new(self, data)
  end


  # Idiomatic facade: client.authenticated.list / client.authenticated.load({ "id" => ... })
  def authenticated
    require_relative 'entity/authenticated_entity'
    @authenticated ||= AuthenticatedEntity.new(self, nil)
  end

  # Deprecated: use client.authenticated instead.
  def Authenticated(data = nil)
    require_relative 'entity/authenticated_entity'
    AuthenticatedEntity.new(self, data)
  end


  # Idiomatic facade: client.daily_reward.list / client.daily_reward.load({ "id" => ... })
  def daily_reward
    require_relative 'entity/daily_reward_entity'
    @daily_reward ||= DailyRewardEntity.new(self, nil)
  end

  # Deprecated: use client.daily_reward instead.
  def DailyReward(data = nil)
    require_relative 'entity/daily_reward_entity'
    DailyRewardEntity.new(self, data)
  end


  # Idiomatic facade: client.game_mechanic.list / client.game_mechanic.load({ "id" => ... })
  def game_mechanic
    require_relative 'entity/game_mechanic_entity'
    @game_mechanic ||= GameMechanicEntity.new(self, nil)
  end

  # Deprecated: use client.game_mechanic instead.
  def GameMechanic(data = nil)
    require_relative 'entity/game_mechanic_entity'
    GameMechanicEntity.new(self, data)
  end


  # Idiomatic facade: client.guild.list / client.guild.load({ "id" => ... })
  def guild
    require_relative 'entity/guild_entity'
    @guild ||= GuildEntity.new(self, nil)
  end

  # Deprecated: use client.guild instead.
  def Guild(data = nil)
    require_relative 'entity/guild_entity'
    GuildEntity.new(self, data)
  end


  # Idiomatic facade: client.guild_authenticated.list / client.guild_authenticated.load({ "id" => ... })
  def guild_authenticated
    require_relative 'entity/guild_authenticated_entity'
    @guild_authenticated ||= GuildAuthenticatedEntity.new(self, nil)
  end

  # Deprecated: use client.guild_authenticated instead.
  def GuildAuthenticated(data = nil)
    require_relative 'entity/guild_authenticated_entity'
    GuildAuthenticatedEntity.new(self, data)
  end


  # Idiomatic facade: client.home_instance.list / client.home_instance.load({ "id" => ... })
  def home_instance
    require_relative 'entity/home_instance_entity'
    @home_instance ||= HomeInstanceEntity.new(self, nil)
  end

  # Deprecated: use client.home_instance instead.
  def HomeInstance(data = nil)
    require_relative 'entity/home_instance_entity'
    HomeInstanceEntity.new(self, data)
  end


  # Idiomatic facade: client.item.list / client.item.load({ "id" => ... })
  def item
    require_relative 'entity/item_entity'
    @item ||= ItemEntity.new(self, nil)
  end

  # Deprecated: use client.item instead.
  def Item(data = nil)
    require_relative 'entity/item_entity'
    ItemEntity.new(self, data)
  end


  # Idiomatic facade: client.map.list / client.map.load({ "id" => ... })
  def map
    require_relative 'entity/map_entity'
    @map ||= MapEntity.new(self, nil)
  end

  # Deprecated: use client.map instead.
  def Map(data = nil)
    require_relative 'entity/map_entity'
    MapEntity.new(self, data)
  end


  # Idiomatic facade: client.map_information.list / client.map_information.load({ "id" => ... })
  def map_information
    require_relative 'entity/map_information_entity'
    @map_information ||= MapInformationEntity.new(self, nil)
  end

  # Deprecated: use client.map_information instead.
  def MapInformation(data = nil)
    require_relative 'entity/map_information_entity'
    MapInformationEntity.new(self, data)
  end


  # Idiomatic facade: client.miscellaneous.list / client.miscellaneous.load({ "id" => ... })
  def miscellaneous
    require_relative 'entity/miscellaneous_entity'
    @miscellaneous ||= MiscellaneousEntity.new(self, nil)
  end

  # Deprecated: use client.miscellaneous instead.
  def Miscellaneous(data = nil)
    require_relative 'entity/miscellaneous_entity'
    MiscellaneousEntity.new(self, data)
  end


  # Idiomatic facade: client.story.list / client.story.load({ "id" => ... })
  def story
    require_relative 'entity/story_entity'
    @story ||= StoryEntity.new(self, nil)
  end

  # Deprecated: use client.story instead.
  def Story(data = nil)
    require_relative 'entity/story_entity'
    StoryEntity.new(self, data)
  end


  # Idiomatic facade: client.structured_pv_p.list / client.structured_pv_p.load({ "id" => ... })
  def structured_pv_p
    require_relative 'entity/structured_pv_p_entity'
    @structured_pv_p ||= StructuredPvPEntity.new(self, nil)
  end

  # Deprecated: use client.structured_pv_p instead.
  def StructuredPvP(data = nil)
    require_relative 'entity/structured_pv_p_entity'
    StructuredPvPEntity.new(self, data)
  end


  # Idiomatic facade: client.trading_post.list / client.trading_post.load({ "id" => ... })
  def trading_post
    require_relative 'entity/trading_post_entity'
    @trading_post ||= TradingPostEntity.new(self, nil)
  end

  # Deprecated: use client.trading_post instead.
  def TradingPost(data = nil)
    require_relative 'entity/trading_post_entity'
    TradingPostEntity.new(self, data)
  end


  # Idiomatic facade: client.world_vs_world.list / client.world_vs_world.load({ "id" => ... })
  def world_vs_world
    require_relative 'entity/world_vs_world_entity'
    @world_vs_world ||= WorldVsWorldEntity.new(self, nil)
  end

  # Deprecated: use client.world_vs_world instead.
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
