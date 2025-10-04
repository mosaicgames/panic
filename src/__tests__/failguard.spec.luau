local ReplicatedStorage = game:GetService("ReplicatedStorage")
local failGuard = require(ReplicatedStorage.Packages.panic.failGuard)
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

it("should set and handle abort policy", function()
	local fg = failGuard.new()
	fg:setPolicy("_fgabort", "abort")

	local policyResult = fg:handle("_fgabort")

	expect(policyResult).toBe("abort")
end)

it("should set and handle ignore policy", function()
	local fg = failGuard.new()
	fg:setPolicy("_fgignore", "ignore")

	local policyResult = fg:handle("_fgignore")

	expect(policyResult).toBe("ignore")
end)

it("should ignore if no policy is set", function()
	local fg = failGuard.new()
	local result = fg:handle("undefined")
	expect(result).toBe("ignore")
end)
