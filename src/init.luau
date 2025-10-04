local failGuard = require(script.failGuard)
local try = require(script.try)
local types = require(script.types)

local Panic = {}
Panic.__index = Panic

function new()
	local self = setmetatable({}, Panic)
	self.failguard = failGuard.new() :: any

	self:Set("_panic", "ignore")
	self:Set("_default", "ignore")
	return self
end

function Panic:Set(tag: string, policy: types.Policy)
	self.failguard:setPolicy(tag, policy)
end

function Panic:Try(fn, Opts: types.Opts?)
	return try(fn, self.failguard, Opts)
end

local panic = new()

return panic
