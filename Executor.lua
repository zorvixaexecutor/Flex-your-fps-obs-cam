local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({
    Title = "Flex your FPS SPOOFER",
    Icon = "file-video-camera", -- lucide icon. optional
    Author = "by BROTHAISHACKIER", -- optional
})

local settings = {
	camera = {
		Enabled = false,
		Input = "https://pastebin.com/raw/NDCszTzV",
		FPS = 10,
		WIDTH = 160,
		HEIGHT = 90
	},
	CustomText = "1440P",
	Memory = "2009 MB",
	Resolution = {
		X = 2560,
		Y = 1440
	},
	GQ = 10,
	Ping = 52,
	FPS = 856,
	Device = "Windows"
}

local scri = Players.LocalPlayer.PlayerScripts:FindFirstChild("CilentStatsSender")
if scri then
	scri:Destroy()
end

local save = tostring(tick())

local gng = ReplicatedStorage:FindFirstChild("hello")
if not gng then
	gng = Instance.new("StringValue")
	gng.Name = "hello"
	gng.Parent = ReplicatedStorage
end

gng.Value = save

local Main = Window:Tab({
    Title = "Spoofer Main",
    Icon = "airplay", -- optional
    Locked = false,
})

local FPS = Main:Section({
    Title = "FPS",
    Icon = "bird",
    Opened = false,
})
FPS:Input({
    Title = "Input",
    Desc = "Input for FPS",
    Value = "856",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "Enter FPS amount",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp and inp <= 20000 and inp >= 1 then
			settings.FPS = inp
		end
    end
})
local Ping = Main:Section({
    Title = "Ping",
    Icon = "bird",
    Opened = false,
})
Ping:Input({
    Title = "Input",
    Desc = "Input for Ping",
    Value = "52",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "Enter Ping amount",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp and inp <= 50000 and inp >= 0 then
			settings.Ping = inp
		end
    end
})
local Device = Main:Section({
    Title = "Device",
    Icon = "bird",
    Opened = false,
})

Device:Dropdown({
    Title = "Selection",
    Desc = "Selecttion for Device",
    Values = { "Windows", "Windows Mobile", "Linux", "macOS", "Android", "iOS", "Xbox", "PlayStation 4", "PlayStation 5", "Meta VR"},
    Value = "Windows",
    Callback = function(option) 
        settings.Device = option
    end
})

local GQ = Main:Section({
    Title = "Graphics Quality",
    Icon = "bird",
    Opened = false,
})

GQ:Input({
    Title = "Input",
    Desc = "Input a valid number for Graphics Quality",
    Value = "10",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Auto",
    Callback = function(input) 
        if input == "" then
			settings.GQ = "Auto"
		else
			local inp = tonumber(input)
			if inp and inp <= 10 and inp >= 1 then
				settings.GQ = inp
			end
		end
    end
})

local Memory = Main:Section({
    Title = "Memory",
    Icon = "bird",
    Opened = false,
})

Memory:Input({
    Title = "Input",
    Desc = "Input for Memory",
    Value = "2009",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "Enter Memory Amount",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp and inp <= 6000 and inp >= 1 then
			settings.Memory = tostring(inp) .. " MB"
		end
    end
})

local Resolution = Main:Section({
    Title = "Resolution",
    Icon = "bird",
    Opened = false,
})
Resolution:Input({
    Title = "Input X",
    Desc = "Input for X axis of Resolution",
    Value = "2560",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Enter Resolution X axis",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp and inp <= 99999 and inp >= 1 then
			settings.Resolution.X = tostring(inp)
		end
    end
})
Resolution:Input({
    Title = "Input Y",
    Desc = "Input for Y axis of Resolution",
    Value = "1440",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Enter Resolution Y axis",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp and inp <= 99999 and inp >= 1 then
			settings.Resolution.Y = tostring(inp)
		end
    end
})
local CT = Main:Section({
    Title = "Custom Text",
    Icon = "bird",
    Opened = false,
})
local damn = "1440P"
CT:Input({
    Title = "Input",
    Desc = "Input for Custom Text",
    Value = "1440P",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Enter text",
    Callback = function(input) 
        if not settings.camera.Enabled then
			settings.CustomText = input
			damn = input
		else
			damn = input
		end
    end
})
CT:Toggle({
    Title = "Camera Feed",
    Desc = "Toggle Camera Feed NOTE: overrides CustomText",
    Icon = "bird",
    Type = "Checkbox",
    Value = false, -- default value
    Callback = function(state) 
        settings.camera.Enabled = state
		if state == false then
			settings.CustomText = damn
		end
    end
})
CT:Input({
    Title = "Feed URI",
    Desc = "Input for URI",
    Value = "https://pastebin.com/raw/NDCszTzV",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Example: http://139.0.45.24:5000",
    Callback = function(input) 
        settings.camera.Input = input
    end
})
CT:Input({
    Title = "Feed Width",
    Desc = "Input for Feed Width",
    Value = "160",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Put the same as python script",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp then
			settings.camera.WIDTH = inp
		end
    end
})
CT:Input({
    Title = "Feed Height",
    Desc = "Input for Feed Height",
    Value = "90",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Put the same as python script",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp then
			settings.camera.HEIGHT = inp
		end
    end
})
CT:Input({
    Title = "Feed FPS",
    Desc = "Input for Feed FPS",
    Value = "10",
    InputIcon = "bird",
    Type = "Input", -- or "Textarea"
    Placeholder = "Put the same as python script",
    Callback = function(input) 
        local inp = tonumber(input)
		if inp then
			settings.camera.FPS = inp
		end
    end
})

local function Color3FromRGB(r, g, b)
	return string.format('<font color="#%02X%02X%02X">■</font>', r, g, b)
end

task.spawn(function()
	while true do
		if gng.Value ~= save then
			break
		end
		if settings.camera.Enabled then
			local ok, result = pcall(function()
				return game:HttpGet(settings.camera.Input)
			end)

			if ok and result then
				local lines = {}

				local y = 1
				for row in string.gmatch(result, "[^|]+") do
					local pixels = {}

					for pixel in string.gmatch(row, "[^;]+") do
						local r, g, b = pixel:match("(%d+),(%d+),(%d+)")
						if r then
							table.insert(pixels, Color3FromRGB(tonumber(r), tonumber(g), tonumber(b)))
						end
					end

					lines[y] = table.concat(pixels)
					y += 1
				end

				settings.CustomText = "\n" .. table.concat(lines, "\n") .. "\n"
			else
				settings.CustomText = "\nfailed to fetch camera output\n"
			end
			if not settings.camera.Enabled then
				settings.CustomText = damn
			end
		end
		task.wait(1 / settings.camera.FPS)
	end
end)
task.spawn(function()
	while true do
		if gng.Value ~= save then
			break
		end

		ReplicatedStorage:WaitForChild("PlayerStatsUpdate"):FireServer({
			Device = settings.Device,
			FPS = settings.FPS,
			Ping = settings.Ping,
			PingRequest = 0, -- Does nothing
			Friends = 0, -- Does nothing
			Badges = 0, -- Does nothing
			GraphicsQuality = settings.GQ,
			Resolution = tostring(settings.Resolution.X) .. "x".. tostring(settings.Resolution.Y) .. " (" .. tostring(settings.CustomText) .. ")",
			Memory = settings.Memory
		})

		task.wait(0.5)
	end
end)