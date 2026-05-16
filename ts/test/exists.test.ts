
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { GuildWars2SDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await GuildWars2SDK.test()
    equal(null !== testsdk, true)
  })

})
