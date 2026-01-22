-- Raft 101 | Bring + Auto Kill + Speed | Delta Mobile

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local bring, kill, speedOn = false, false, false
local normalSpeed = 16
local fastSpeed = 32

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Raft101GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 170)
frame.Position = UDim2.new(0, 20, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "Raft 101"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close button
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(60,20,20)

Instance.new("UICorner", close).CornerRadius = UDim.new(0,8)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Button creator
local function makeBtn(text, y)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, -20, 0, 35)
	b.Position = UDim2.new(0, 10, 0, y)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local bringBtn = makeBtn("BRING: OFF", 45)
local killBtn  = makeBtn("AUTO KILL: OFF", 85)
local spdBtn   = makeBtn("SPEED: OFF", 125)

bringBtn.MouseButton1Click:Connect(function()
	bring = not bring
	bringBtn.Text = "BRING: " .. (bring and "ON" or "OFF")
end)

killBtn.MouseButton1Click:Connect(function()
	kill = not kill
	killBtn.Text = "AUTO KILL: " .. (kill and "ON" or "OFF")
end)

spdBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	spdBtn.Text = "SPEED: " .. (speedOn and "ON" or "OFF")
end)

-- Main loop
RunService.Heartbeat:Connect(function()
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	-- Speed
	hum.WalkSpeed = speedOn and fastSpeed or normalSpeed

	-- Bring + Kill
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
			if v ~= char then
				if bring then
					v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
				end
				if kill then
					v.Humanoid.Health = 0
				end
			end
		end
	end
end)
