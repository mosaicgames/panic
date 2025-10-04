local types = require(script.Parent.types)

local FailGuard = {}
FailGuard.__index = FailGuard

function FailGuard.new()
	local self = setmetatable({}, FailGuard)
	self.policies = {} :: { [string]: types.Policy }
	return self
end

function FailGuard:setPolicy(tag: string, policy: types.Policy)
	self.policies[tag] = policy
end

function FailGuard:handle(tag: string)
	local policy = self.policies[tag] or "ignore"

	if policy == "abort" then
		if game:GetService("RunService"):IsStudio() then
			warn("[FailGuard] Shutdown wont work in studip. Using kick method...")
			task.wait(1)
			for _, plr in ipairs(game.Players:GetPlayers()) do
				plr:Kick("Server Panicked. This is not your fault, Try Rejoining!")
			end
		else
			game:Shutdown()
		end
	end
end

return FailGuard
