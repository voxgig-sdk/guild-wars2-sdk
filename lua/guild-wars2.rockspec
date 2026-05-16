package = "voxgig-sdk-guild-wars2"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/guild-wars2-sdk.git"
}
description = {
  summary = "GuildWars2 SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["guild-wars2_sdk"] = "guild-wars2_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
