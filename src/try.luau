local logger = require(script.Parent.logger)
local types = require(script.Parent.types)

return function(fn: () -> ...any, failguard: any, opts: types.Opts?): (boolean, ...any)
	local options = opts or { tag = "_default" }

	if not options.tag then
		options["tag"] = "_default"
	end

	-- Greedy way sorry
	local results = { pcall(function()
		return fn()
	end) }

	local ok = table.remove(results, 1)

	if not ok then
		local err = results[1]
		logger(tostring(err), options or {})
		failguard:handle(options.tag)

		return false
	end

	return true, table.unpack(results)
end
