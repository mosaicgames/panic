local types = require(script.Parent.types)

local FailGuard = {}
FailGuard.__index = FailGuard

function FailGuard.new()
	local self = setmetatable({}, FailGuard)
	self.policies = {
		["_panic"] = "ignore",
		["_default"] = "ignore",
	} :: types.PolicyMap
	return self
end

function FailGuard:setPolicy(tag: string, policy: types.Policy)
	self.policies[tag] = policy
end

function FailGuard:handle(tag: string)
	local policy: types.Policy = self.policies[tag]
	if not policy then
		policy = "ignore"
	end

	-- This is used in the test process of the library this prevents policies from working
	if workspace:GetAttribute("__PANIC_CLOUD_TEST_ENV") then
		return policy
	end

	if policy == "abort" then
		if game:GetService("RunService"):IsStudio() then
			warn("[FailGuard] Shutdown wont work in studio. Using kick method...")
			task.wait(1)
			for _, plr in ipairs(game.Players:GetPlayers()) do
				plr:Kick("Server Panicked. This is not your fault, Try Rejoining!")
			end
		else
			game:Shutdown()
		end
	end
	return policy
end

return FailGuard
