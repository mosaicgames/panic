local types = require(script.Parent.types)

local Logger = {}
Logger.__index = Logger

local START_TIME = os.clock()

local function isoTimestamp()
	return os.date("!%Y-%m-%dT%H:%M:%SZ")
end

local function formatUptime(sec)
	sec = math.floor(sec or 0)
	local h = math.floor(sec / 3600)
	sec = sec - h * 3600
	local m = math.floor(sec / 60)
	sec = sec - m * 60
	local s = sec
	if h > 0 then
		return string.format("%dh %dm %ds", h, m, s)
	elseif m > 0 then
		return string.format("%dm %ds", m, s)
	else
		return string.format("%ds", s)
	end
end

local function gatherBacktrace(skipLevel)
	local trace = debug.traceback(nil, skipLevel or 3)
	local out = {}
	for line in trace:gmatch("[^\n]+") do
		if not line:match("debug.traceback") and not line:match("stack traceback") then
			local t = line:gsub("^%s+", ""):gsub("%s+$", "")
			if #t > 0 then
				table.insert(out, t)
			end
		end
	end
	return out
end

function Logger.log(msg, opts: types.Opts)
	opts = opts or {}
	local tags= opts.tags or {}
	local skip = 3

	local ts = isoTimestamp()
	local uptime = formatUptime(os.clock() - START_TIME)

	local back = gatherBacktrace(skip)

	local tagStr = ""
	if #tags > 0 then
		tagStr = " [" .. table.concat(tags, "][") .. "]"
	end

	local out = {}
	table.insert(out, string.format("🚨 [PANIC] %s  🟡 | %s", ts, tagStr))
	table.insert(out, string.format("⏱️ Uptime: %s", uptime))
	table.insert(out, string.format("❗ Error : %s", tostring(msg)))

	if #back > 0 then
		table.insert(out, "🔎 Backtrace:")
		for i = 1, #back do
			table.insert(out, "   ↳ " .. back[i])
		end
	end

	local final = table.concat(out, "\n")
	warn(final)
	return nil
end

return setmetatable({}, { __index = Logger })
