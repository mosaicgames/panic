local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

local logger = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("panic"):WaitForChild("logger"))

it("should return correct log structure", function()
	local result = logger("Im so panic bro", { tag = "test" })
	expect(result).toBe(true)
end)
