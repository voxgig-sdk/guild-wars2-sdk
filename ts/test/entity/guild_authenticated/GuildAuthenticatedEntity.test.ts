
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'


import { GuildWars2SDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


describe('GuildAuthenticatedEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when GUILDWARS2_TEST_LIVE=TRUE.
  afterEach(liveDelay('GUILDWARS2_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = GuildWars2SDK.test()
    const ent = testsdk.GuildAuthenticated()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.GUILD_WARS__TEST_LIVE
    for (const op of ['list']) {
      if (maybeSkipControl(t, 'entityOp', 'guild_authenticated.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set GUILD_WARS__TEST_GUILD_AUTHENTICATED_ENTID JSON to run live')
      return
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let guild_authenticated_ref01_data = Object.values(setup.data.existing.guild_authenticated)[0] as any

    // LIST
    const guild_authenticated_ref01_ent = client.GuildAuthenticated()
    const guild_authenticated_ref01_match: any = {}

    const guild_authenticated_ref01_list = await guild_authenticated_ref01_ent.list(guild_authenticated_ref01_match)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/guild_authenticated/GuildAuthenticatedTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = GuildWars2SDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['guild_authenticated01','guild_authenticated02','guild_authenticated03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  const idmapEnvVal = process.env['GUILD_WARS__TEST_GUILD_AUTHENTICATED_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'GUILD_WARS__TEST_GUILD_AUTHENTICATED_ENTID': idmap,
    'GUILD_WARS__TEST_LIVE': 'FALSE',
    'GUILD_WARS__TEST_EXPLAIN': 'FALSE',
    'GUILD_WARS__APIKEY': 'NONE',
  })

  idmap = env['GUILD_WARS__TEST_GUILD_AUTHENTICATED_ENTID']

  const live = 'TRUE' === env.GUILD_WARS__TEST_LIVE

  if (live) {
    client = new GuildWars2SDK(merge([
      {
        apikey: env.GUILD_WARS__APIKEY,
      },
      extra
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.GUILD_WARS__TEST_EXPLAIN,
    live,
    syntheticOnly: live && !idmapOverridden,
    now: Date.now(),
  }

  return setup
}
  
