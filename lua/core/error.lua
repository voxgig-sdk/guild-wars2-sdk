-- GuildWars2 SDK error

local GuildWars2Error = {}
GuildWars2Error.__index = GuildWars2Error


function GuildWars2Error.new(code, msg, ctx)
  local self = setmetatable({}, GuildWars2Error)
  self.is_sdk_error = true
  self.sdk = "GuildWars2"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function GuildWars2Error:error()
  return self.msg
end


function GuildWars2Error:__tostring()
  return self.msg
end


return GuildWars2Error
