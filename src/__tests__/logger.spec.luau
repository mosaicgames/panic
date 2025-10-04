local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

local logger = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("panic"):WaitForChild("logger"))

it("should log error message with tag", function()
	local ok = logger("Test error", { tag = "_panic" })
	expect(ok).to.equal(true)
end)

it("should fallback to _default tag if none provided", function()
	local ok = logger("Another error")
	expect(ok).to.equal(true)
end)
