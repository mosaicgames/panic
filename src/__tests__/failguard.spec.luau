local ReplicatedStorage = game:GetService("ReplicatedStorage")
local failGuard = require(ReplicatedStorage.Packages.panic.failGuard)
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

it("should set and handle a custom policy", function()
	local fg = failGuard.new() :: any
	fg:setPolicy("_custom", "abort")

	local policyResult = fg:handle("_custom")
	expect(policyResult).to.equal("abort")
end)

it("should ignore if no policy is set", function()
	local fg = failGuard.new()
	local result = fg:handle("undefined")
	expect(result).to.equal("ignore")
end)
