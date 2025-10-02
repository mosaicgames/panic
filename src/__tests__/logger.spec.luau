local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

local logger = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("panic")).logger

it("should return correct log structure", function()
	local result = logger.log("Test Message", "warn")
	expect(result.message).toBe("Test Message")
	expect(result.level).toBe("warn")
	expect(typeof(result.timestamp)).toBe("number")
end)
