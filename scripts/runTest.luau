local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jest = require(ReplicatedStorage.DevPackages.Jest)

local runCLI = Jest.runCLI

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Project = Packages:WaitForChild("panic")

local processServiceExists, ProcessService = pcall(function()
	return game:GetService("ProcessService")
end)

workspace:SetAttribute("__PANIC_CLOUD_TEST_ENV", true)

local status, result = runCLI(Project, {
	verbose = false,
	ci = false,
}, { Project }):awaitStatus()

if status == "Rejected" then
	print(result)
end

if status == "Resolved" and result.results.numFailedTestSuites == 0 and result.results.numFailedTests == 0 then
	if processServiceExists then
		ProcessService:ExitAsync(0)
	end
end

if processServiceExists then
	ProcessService:ExitAsync(1)
end

return nil
