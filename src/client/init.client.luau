local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WIND_DIRECTION = Vector3.new(1, 0, 0.3)
local WIND_SPEED = 20
local WIND_POWER = 0.5

local Packages = ReplicatedStorage:WaitForChild("Packages")
local WindLines = require(Packages.WindLines)
local WindShake = require(Packages.WindShake)

WindLines:Init({
	Direction = WIND_DIRECTION,
	Speed = WIND_SPEED,
	Lifetime = 2,
	SpawnRate = 15,
})

WindShake:SetDefaultSettings({
	WindSpeed = WIND_SPEED,
	WindDirection = WIND_DIRECTION,
	WindPower = WIND_POWER,
})
WindShake:Init()

workspace.Changed:Connect(function(prop)
	if prop == "GlobalWind" then
		local wind = workspace.GlobalWind
		WIND_DIRECTION = wind
		WindLines.Direction = wind
		WindShake:UpdateAllObjectSettings({ WindDirection = wind })
		WindShake:SetDefaultSettings({ WindDirection = wind })
	end
end)
