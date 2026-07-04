// GuildWars2 Ts SDK

import { AchievementEntity } from './entity/AchievementEntity'
import { AuthenticatedEntity } from './entity/AuthenticatedEntity'
import { DailyRewardEntity } from './entity/DailyRewardEntity'
import { GameMechanicEntity } from './entity/GameMechanicEntity'
import { GuildEntity } from './entity/GuildEntity'
import { GuildAuthenticatedEntity } from './entity/GuildAuthenticatedEntity'
import { HomeInstanceEntity } from './entity/HomeInstanceEntity'
import { ItemEntity } from './entity/ItemEntity'
import { MapEntity } from './entity/MapEntity'
import { MapInformationEntity } from './entity/MapInformationEntity'
import { MiscellaneousEntity } from './entity/MiscellaneousEntity'
import { StoryEntity } from './entity/StoryEntity'
import { StructuredPvPEntity } from './entity/StructuredPvPEntity'
import { TradingPostEntity } from './entity/TradingPostEntity'
import { WorldVsWorldEntity } from './entity/WorldVsWorldEntity'

export type * from './GuildWars2Types'


import { inspect } from 'node:util'

import type { Context, Feature } from './types'

import { config } from './Config'
import { GuildWars2EntityBase } from './GuildWars2EntityBase'
import { Utility } from './utility/Utility'


import { BaseFeature } from './feature/base/BaseFeature'


const stdutil = new Utility()


class GuildWars2SDK {
  _mode: string = 'live'
  _options: any
  _utility = new Utility()
  _features: Feature[]
  _rootctx: Context

  constructor(options?: any) {

    this._rootctx = this._utility.makeContext({
      client: this,
      utility: this._utility,
      config,
      options,
      shared: new WeakMap()
    })

    this._options = this._utility.makeOptions(this._rootctx)

    const struct = this._utility.struct
    const getpath = struct.getpath
    const items = struct.items

    if (true === getpath(this._options.feature, 'test.active')) {
      this._mode = 'test'
    }

    this._rootctx.options = this._options

    this._features = []

    const featureAdd = this._utility.featureAdd
    const featureInit = this._utility.featureInit

    items(this._options.feature, (fitem: [string, any]) => {
      const fname = fitem[0]
      const fopts = fitem[1]
      if (fopts.active) {
        featureAdd(this._rootctx, this._rootctx.config.makeFeature(fname))
      }
    })

    if (null != this._options.extend) {
      for (let f of this._options.extend) {
        featureAdd(this._rootctx, f)
      }
    }

    for (let f of this._features) {
      featureInit(this._rootctx, f)
    }

    const featureHook = this._utility.featureHook
    featureHook(this._rootctx, 'PostConstruct')
  }


  options() {
    return this._utility.struct.clone(this._options)
  }


  utility() {
    return this._utility.struct.clone(this._utility)
  }


  async prepare(fetchargs?: any) {
    const utility = this._utility
    const struct = utility.struct
    const clone = struct.clone

    const {
      makeContext,
      makeFetchDef,
      prepareHeaders,
      prepareAuth,
    } = utility

    fetchargs = fetchargs || {}

    let ctx: Context = makeContext({
      opname: 'prepare',
      ctrl: fetchargs.ctrl || {},
    }, this._rootctx)

    const options = this._options

    // Build spec directly from SDK options + user-provided fetch args.
    const spec: any = {
      base: options.base,
      prefix: options.prefix,
      suffix: options.suffix,
      path: fetchargs.path || '',
      method: fetchargs.method || 'GET',
      params: fetchargs.params || {},
      query: fetchargs.query || {},
      headers: prepareHeaders(ctx),
      body: fetchargs.body,
      step: 'start',
    }

    ctx.spec = spec

    // Merge user-provided headers over SDK defaults.
    if (fetchargs.headers) {
      const uheaders = fetchargs.headers
      for (let key in uheaders) {
        spec.headers[key] = uheaders[key]
      }
    }

    // Apply SDK auth (apikey, auth prefix, etc.)
    const authResult = prepareAuth(ctx)
    if (authResult instanceof Error) {
      return authResult
    }

    return makeFetchDef(ctx)
  }


  async direct(fetchargs?: any) {
    const utility = this._utility
    const fetcher = utility.fetcher
    const makeContext = utility.makeContext

    const fetchdef = await this.prepare(fetchargs)
    if (fetchdef instanceof Error) {
      return fetchdef
    }

    let ctx: Context = makeContext({
      opname: 'direct',
      ctrl: (fetchargs || {}).ctrl || {},
    }, this._rootctx)

    try {
      const fetched = await fetcher(ctx, fetchdef.url, fetchdef)

      if (null == fetched) {
        return { ok: false, err: ctx.error('direct_no_response', 'response: undefined') }
      }
      else if (fetched instanceof Error) {
        return { ok: false, err: fetched }
      }

      const status = fetched.status

      // No body responses (204 No Content, 304 Not Modified) and explicit
      // zero content-length must skip JSON parsing — fetched.json() would
      // throw `Unexpected end of JSON input` on an empty body.
      const headers = fetched.headers
      const contentLength = headers && 'function' === typeof headers.get
        ? headers.get('content-length')
        : (headers || {})['content-length']
      const noBody = 204 === status || 304 === status || '0' === String(contentLength)

      let json: any = undefined
      if (!noBody) {
        try {
          json = 'function' === typeof fetched.json ? await fetched.json() : fetched.json
        }
        catch (parseErr) {
          // Body wasn't valid JSON — surface the raw response rather than
          // throwing. data stays undefined; callers can inspect status/headers.
          json = undefined
        }
      }

      return {
        ok: status >= 200 && status < 300,
        status,
        headers: fetched.headers,
        data: json,
      }
    }
    catch (err: any) {
      return { ok: false, err }
    }
  }



  _achievement?: AchievementEntity

  // Idiomatic facade: `client.achievement.list()` / `client.achievement.load({ id })`.
  get achievement(): AchievementEntity {
    return (this._achievement ??= new AchievementEntity(this, undefined))
  }

  /** @deprecated Use `client.achievement` instead. */
  Achievement(data?: any) {
    const self = this
    return new AchievementEntity(self,data)
  }


  _authenticated?: AuthenticatedEntity

  // Idiomatic facade: `client.authenticated.list()` / `client.authenticated.load({ id })`.
  get authenticated(): AuthenticatedEntity {
    return (this._authenticated ??= new AuthenticatedEntity(this, undefined))
  }

  /** @deprecated Use `client.authenticated` instead. */
  Authenticated(data?: any) {
    const self = this
    return new AuthenticatedEntity(self,data)
  }


  _daily_reward?: DailyRewardEntity

  // Idiomatic facade: `client.daily_reward.list()` / `client.daily_reward.load({ id })`.
  get daily_reward(): DailyRewardEntity {
    return (this._daily_reward ??= new DailyRewardEntity(this, undefined))
  }

  /** @deprecated Use `client.daily_reward` instead. */
  DailyReward(data?: any) {
    const self = this
    return new DailyRewardEntity(self,data)
  }


  _game_mechanic?: GameMechanicEntity

  // Idiomatic facade: `client.game_mechanic.list()` / `client.game_mechanic.load({ id })`.
  get game_mechanic(): GameMechanicEntity {
    return (this._game_mechanic ??= new GameMechanicEntity(this, undefined))
  }

  /** @deprecated Use `client.game_mechanic` instead. */
  GameMechanic(data?: any) {
    const self = this
    return new GameMechanicEntity(self,data)
  }


  _guild?: GuildEntity

  // Idiomatic facade: `client.guild.list()` / `client.guild.load({ id })`.
  get guild(): GuildEntity {
    return (this._guild ??= new GuildEntity(this, undefined))
  }

  /** @deprecated Use `client.guild` instead. */
  Guild(data?: any) {
    const self = this
    return new GuildEntity(self,data)
  }


  _guild_authenticated?: GuildAuthenticatedEntity

  // Idiomatic facade: `client.guild_authenticated.list()` / `client.guild_authenticated.load({ id })`.
  get guild_authenticated(): GuildAuthenticatedEntity {
    return (this._guild_authenticated ??= new GuildAuthenticatedEntity(this, undefined))
  }

  /** @deprecated Use `client.guild_authenticated` instead. */
  GuildAuthenticated(data?: any) {
    const self = this
    return new GuildAuthenticatedEntity(self,data)
  }


  _home_instance?: HomeInstanceEntity

  // Idiomatic facade: `client.home_instance.list()` / `client.home_instance.load({ id })`.
  get home_instance(): HomeInstanceEntity {
    return (this._home_instance ??= new HomeInstanceEntity(this, undefined))
  }

  /** @deprecated Use `client.home_instance` instead. */
  HomeInstance(data?: any) {
    const self = this
    return new HomeInstanceEntity(self,data)
  }


  _item?: ItemEntity

  // Idiomatic facade: `client.item.list()` / `client.item.load({ id })`.
  get item(): ItemEntity {
    return (this._item ??= new ItemEntity(this, undefined))
  }

  /** @deprecated Use `client.item` instead. */
  Item(data?: any) {
    const self = this
    return new ItemEntity(self,data)
  }


  _map?: MapEntity

  // Idiomatic facade: `client.map.list()` / `client.map.load({ id })`.
  get map(): MapEntity {
    return (this._map ??= new MapEntity(this, undefined))
  }

  /** @deprecated Use `client.map` instead. */
  Map(data?: any) {
    const self = this
    return new MapEntity(self,data)
  }


  _map_information?: MapInformationEntity

  // Idiomatic facade: `client.map_information.list()` / `client.map_information.load({ id })`.
  get map_information(): MapInformationEntity {
    return (this._map_information ??= new MapInformationEntity(this, undefined))
  }

  /** @deprecated Use `client.map_information` instead. */
  MapInformation(data?: any) {
    const self = this
    return new MapInformationEntity(self,data)
  }


  _miscellaneous?: MiscellaneousEntity

  // Idiomatic facade: `client.miscellaneous.list()` / `client.miscellaneous.load({ id })`.
  get miscellaneous(): MiscellaneousEntity {
    return (this._miscellaneous ??= new MiscellaneousEntity(this, undefined))
  }

  /** @deprecated Use `client.miscellaneous` instead. */
  Miscellaneous(data?: any) {
    const self = this
    return new MiscellaneousEntity(self,data)
  }


  _story?: StoryEntity

  // Idiomatic facade: `client.story.list()` / `client.story.load({ id })`.
  get story(): StoryEntity {
    return (this._story ??= new StoryEntity(this, undefined))
  }

  /** @deprecated Use `client.story` instead. */
  Story(data?: any) {
    const self = this
    return new StoryEntity(self,data)
  }


  _structured_pv_p?: StructuredPvPEntity

  // Idiomatic facade: `client.structured_pv_p.list()` / `client.structured_pv_p.load({ id })`.
  get structured_pv_p(): StructuredPvPEntity {
    return (this._structured_pv_p ??= new StructuredPvPEntity(this, undefined))
  }

  /** @deprecated Use `client.structured_pv_p` instead. */
  StructuredPvP(data?: any) {
    const self = this
    return new StructuredPvPEntity(self,data)
  }


  _trading_post?: TradingPostEntity

  // Idiomatic facade: `client.trading_post.list()` / `client.trading_post.load({ id })`.
  get trading_post(): TradingPostEntity {
    return (this._trading_post ??= new TradingPostEntity(this, undefined))
  }

  /** @deprecated Use `client.trading_post` instead. */
  TradingPost(data?: any) {
    const self = this
    return new TradingPostEntity(self,data)
  }


  _world_vs_world?: WorldVsWorldEntity

  // Idiomatic facade: `client.world_vs_world.list()` / `client.world_vs_world.load({ id })`.
  get world_vs_world(): WorldVsWorldEntity {
    return (this._world_vs_world ??= new WorldVsWorldEntity(this, undefined))
  }

  /** @deprecated Use `client.world_vs_world` instead. */
  WorldVsWorld(data?: any) {
    const self = this
    return new WorldVsWorldEntity(self,data)
  }




  static test(testoptsarg?: any, sdkoptsarg?: any) {
    const struct = stdutil.struct
    const setpath = struct.setpath
    const getdef = struct.getdef
    const clone = struct.clone
    const setprop = struct.setprop

    const sdkopts = getdef(clone(sdkoptsarg), {})
    const testopts = getdef(clone(testoptsarg), {})
    setprop(testopts, 'active', true)
    setpath(sdkopts, 'feature.test', testopts)

    const testsdk = new GuildWars2SDK(sdkopts)
    testsdk._mode = 'test'

    return testsdk
  }


  tester(testopts?: any, sdkopts?: any) {
    return GuildWars2SDK.test(testopts, sdkopts)
  }


  toJSON() {
    return { name: 'GuildWars2' }
  }

  toString() {
    return 'GuildWars2 ' + this._utility.struct.jsonify(this.toJSON())
  }

  [inspect.custom]() {
    return this.toString()
  }

}




const SDK = GuildWars2SDK


export {
  stdutil,

  BaseFeature,
  GuildWars2EntityBase,

  GuildWars2SDK,
  SDK,
}


