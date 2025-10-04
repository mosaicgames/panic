local ReplicatedStorage = game:GetService("ReplicatedStorage")
local panic = require(script.Parent.Parent)
local JestGlobals = require(ReplicatedStorage:WaitForChild("DevPackages"):WaitForChild("JestGlobals"))

local it = JestGlobals.it
local expect = JestGlobals.expect

local function testThatAlwaysFail()
	if 2 + 2 == 4 then
		error("Unfortunately its correct")
	end

	return true
end

local function testThatAlwaysSuccess()
	return true
end

local function testWithMultipleReturns()
	return "hello", "world", 123
end

-- Try with abort
it("should handle error with abort policy", function()
	panic:Set("_iabort", "abort")
	local ok, result = panic:Try(testThatAlwaysFail, { tag = "_iabort" })
	expect(ok).toBe(false)
	expect(result).toBe(nil)
end)

-- Try with ignore
it("should handle error with ignore policy", function()
	panic:Set("_iignore", "ignore")
	local ok, result = panic:Try(testThatAlwaysFail, { tag = "_iignore" })
	expect(ok).toBe(false)
	expect(result).toBe(nil)
end)

-- Try with opts
it("should handle function with opts provided", function()
	panic:Set("_withopts", "ignore")
	local ok, result = panic:Try(testThatAlwaysSuccess, { tag = "_withopts" })
	expect(ok).toBe(true)
	expect(result).toBe(true)
end)

-- Try without opts
it("should handle function without opts (default behavior)", function()
	local ok, result = panic:Try(testThatAlwaysSuccess)
	expect(ok).toBe(true)
	expect(result).toBe(true)
end)

-- Try with unexistent tag
it("should use default policy when tag doesn't exist", function()
	local ok, result = panic:Try(testThatAlwaysFail, { tag = "_nonexistent" })
	expect(ok).toBe(false)
	expect(result).toBe(nil)
end)

-- Try with correct function
it("should return true and results when function succeeds", function()
	local ok, result = panic:Try(testThatAlwaysSuccess)
	expect(ok).toBe(true)
	expect(result).toBe(true)
end)

-- Try with fail function
it("should return false and nil when function fails", function()
	local ok, result = panic:Try(testThatAlwaysFail)
	expect(ok).toBe(false)
	expect(result).toBe(nil)
end)

-- Try with multiple return values
it("should handle functions with multiple return values", function()
	local ok, val1, val2, val3 = panic:Try(testWithMultipleReturns)
	expect(ok).toBe(true)
	expect(val1).toBe("hello")
	expect(val2).toBe("world")
	expect(val3).toBe(123)
end)
