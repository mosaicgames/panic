local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

local logger = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("panic")).logger

it("should return correct log structure", function()
	local result = logger.log("Im so panic bro", { tags = { "test" } })
	expect(result).toBe(true)
end)
