
import { Context } from './Context'


class GuildWars2Error extends Error {

  isGuildWars2Error = true

  sdk = 'GuildWars2'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  GuildWars2Error
}

