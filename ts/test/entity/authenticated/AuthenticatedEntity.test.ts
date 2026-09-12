

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'


import { GuildWars2SDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


describe('AuthenticatedEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when GUILD_WARS2_TEST_LIVE=TRUE.
  afterEach(liveDelay('GUILD_WARS2_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = GuildWars2SDK.test()
    const ent = testsdk.Authenticated()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.GUILD_WARS2_TEST_LIVE
    for (const op of ['list', 'load']) {
      if (maybeSkipControl(t, 'entityOp', 'authenticated.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set GUILD_WARS2_TEST_AUTHENTICATED_ENTID JSON to run live')
      return
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let authenticated_ref01_data = Object.values(setup.data.existing.authenticated)[0] as any

    // LIST
    const authenticated_ref01_ent = client.Authenticated()
    const authenticated_ref01_match: any = {}

    const authenticated_ref01_list = (await authenticated_ref01_ent.list(authenticated_ref01_match)).map((e: any) => e.data())


    // LOAD
    const authenticated_ref01_match_dt0: any = {}
    authenticated_ref01_match_dt0.id = authenticated_ref01_data.id
    const authenticated_ref01_data_dt0 = (await authenticated_ref01_ent.load(authenticated_ref01_match_dt0)).data()
    assert(authenticated_ref01_data_dt0.id === authenticated_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/authenticated/AuthenticatedTestData.json')

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
    ['authenticated01','authenticated02','authenticated03'],
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
  const idmapEnvVal = process.env['GUILD_WARS2_TEST_AUTHENTICATED_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'GUILD_WARS2_TEST_AUTHENTICATED_ENTID': idmap,
    'GUILD_WARS2_TEST_LIVE': 'FALSE',
    'GUILD_WARS2_TEST_EXPLAIN': 'FALSE',
    'GUILD_WARS2_APIKEY': '',
  })

  idmap = env['GUILD_WARS2_TEST_AUTHENTICATED_ENTID']

  const live = 'TRUE' === env.GUILD_WARS2_TEST_LIVE

  if (live) {
    client = new GuildWars2SDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.GUILD_WARS2_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {}
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.GUILD_WARS2_TEST_EXPLAIN,
    live,
    syntheticOnly: live && !idmapOverridden,
    now: Date.now(),
  }

  return setup
}
  
