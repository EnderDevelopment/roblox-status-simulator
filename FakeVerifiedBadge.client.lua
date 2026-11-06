-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- This creates a cosmetic in-game badge only. It does not change Roblox account verification.

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local badgeText = "VERIFIED"
local badgeColor = Color3.fromRGB(35, 145, 255)

local function addBadge(character: Model)
	local head = character:WaitForChild("Head", 10)
	if not head then
		return
	end

	local oldBadge = head:FindFirstChild("GameOnlyVerifiedBadge")
	if oldBadge then
		oldBadge:Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "GameOnlyVerifiedBadge"
	billboard.Adornee = head
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 100
	billboard.Size = UDim2.fromOffset(150, 28)
	billboard.StudsOffset = Vector3.new(0, 3.1, 0)
	billboard.Parent = head

	local frame = Instance.new("Frame")
	frame.Name = "BadgeFrame"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(24, 29, 38)
	frame.BackgroundTransparency = 0.08
	frame.BorderSizePixel = 0
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.fromScale(1, 1)
	frame.Parent = billboard

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = badgeColor
	stroke.Thickness = 1.5
	stroke.Transparency = 0.1
	stroke.Parent = frame

	local icon = Instance.new("TextLabel")
	icon.Name = "CheckIcon"
	icon.BackgroundTransparency = 1
	icon.Font = Enum.Font.GothamBold
	icon.Text = "✓"
	icon.TextColor3 = badgeColor
	icon.TextSize = 20
	icon.Size = UDim2.fromOffset(26, 28)
	icon.Position = UDim2.fromOffset(5, 0)
	icon.Parent = frame

	local label = Instance.new("TextLabel")
	label.Name = "BadgeLabel"
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.Text = badgeText
	label.TextColor3 = Color3.fromRGB(245, 248, 255)
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(1, -35, 1, 0)
	label.Position = UDim2.fromOffset(32, 0)
	label.Parent = frame

	local tooltip = Instance.new("TextLabel")
	tooltip.Name = "GameOnlyNotice"
	tooltip.AnchorPoint = Vector2.new(0.5, 0)
	tooltip.BackgroundTransparency = 1
	tooltip.Font = Enum.Font.Gotham
	tooltip.Text = "Game-only badge"
	tooltip.TextColor3 = Color3.fromRGB(190, 198, 215)
	tooltip.TextSize = 10
	tooltip.Size = UDim2.fromOffset(150, 16)
	tooltip.Position = UDim2.new(0.5, 0, 1, 2)
	tooltip.Parent = billboard
end

local function onCharacterAdded(character: Model)
	addBadge(character)
end

if player.Character then
	task.spawn(onCharacterAdded, player.Character)
end

player.CharacterAdded:Connect(onCharacterAdded)
