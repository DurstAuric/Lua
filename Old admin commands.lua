local Services = {Players = game:GetService("Players"), MarketplaceService = game:GetService("MarketplaceService"), Lighting = game:GetService("Lighting"), InsertService = game:GetService("InsertService"),} --local Resources = script:FindFirstChild("Resources") -- Hands off pls. No touchy.
local Settings = {
Prefix = ">", -- For firing a command, e.g. ">pm all hello world!"
Splitter = ",", -- For splitting a player's name, e.g. ">pm player1,player2,player3 hello world!"
FunCommands = true, -- Set to false if your place is strict or if you're a boring person who doesn't know what fun is.
VIPAdmin = true,
FreeAdmin = false, -- Set this to true if you want people to be given admin when they join the game.
VIPID = {}, -- Add assets to this to grant VIP access. Example: VIPID = {123456, 1337, 654321}
BannedGears = {}, -- Gear ID's go here. May be in a string or just normal integers/
}
local DefaultSettings = {
Lighting = {Ambient = Services.Lighting.Ambient, Brightness = Services.Lighting.Brightness, ColorShift_Bottom = Services.Lighting.ColorShift_Bottom, ColorShift_Top = Services.Lighting.ColorShift_Top, GlobalShadows = Services.Lighting.GlobalShadows, OutdoorAmbient = Services.Lighting.OutdoorAmbient, Outlines = Services.Lighting.Outlines, TimeOfDay = Services.Lighting.TimeOfDay, FogColor = Services.Lighting.FogColor, FogEnd = Services.Lighting.FogEnd, FogStart = Services.Lighting.FogStart},
-- Idk.
}
local Owners = {"Player1", "DurstAuric",} -- People who can set admins, kick and ban and so on.
local Admins = {"Player2", "Player3",} -- People who can use certain commands.
local Banned = {"SomeNoobWhoAbusesYourGame", "Exploiter",} -- For those who are abusive or you just dislike.

--[[---------------

	Main Script
	¯¯¯¯¯¯¯¯¯¯¯
---------------]]--
function CheckAdmin(Player) for _, Plr in pairs(Admins) do if Plr:lower() == Player.Name:lower() then return true end end end
function CheckOwner(Player) for _, Plr in pairs(Owners) do if Plr:lower() == Player.Name:lower() then return true end end end
function CheckBanned(Player) for _, Plr in pairs(Banned) do if Plr:lower() == Player.Name:lower() then return true end end end
function GetRank(Player) for _, Plr in pairs(Admins) do if Plr:lower() == Player.Name:lower() then return "Admin" end end for _, Plr in pairs(Owners) do if Plr:lower() == Player.Name:lower() then return "Owner" end end end
function CheckVIP(Player) for _, Asset in pairs(Settings.VIPID) do if not CheckAdmin(Player) then if Services.MarketplaceService:PlayerOwnsAsset(Player, Asset) then return true end end end end
function NewInstance(InstanceType, InstanceParent, InstanceName) local NInstance = Instance.new(InstanceType, InstanceParent) NInstance.Name = InstanceName return NInstance end
function CreateMessage(Title, Message, Player, Duration)
local function StartTimer(TextLabel) for Number = Duration, 0, -1 do TextLabel.Text = Number wait(1) end end
coroutine.wrap(function()
if Player.PlayerGui:FindFirstChild("DMessage") then Player.PlayerGui["DMessage"]:Destroy() end
local MainGui = NewInstance("ScreenGui", Player.PlayerGui, "DMessage") local Background = NewInstance("Frame", MainGui, "Background") local MainTitle = NewInstance("TextLabel", Background, "Title")
Background.BackgroundTransparency = 0.5 Background.BorderSizePixel = 2 Background.BorderColor3 = Color3.fromRGB(255, 255, 255) Background.BackgroundColor3 = Color3.fromRGB(32, 32, 32) Background.Size = UDim2.new(1, -4, 1, -4) Background.Position = UDim2.new(-2, 2, 0, 2)
MainTitle.BackgroundTransparency = 1 MainTitle.BorderSizePixel = 0 MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255) MainTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) MainTitle.TextStrokeTransparency = 0.6 MainTitle.Size = UDim2.new(0, 600, 0, 40) MainTitle.Position = UDim2.new(0.5, -300, 0 ,0) MainTitle.Font = Enum.Font.SourceSansItalic MainTitle.TextScaled = true MainTitle.TextWrapped = true MainTitle.Text = Title local Body = MainTitle:Clone() Body.Parent = Background local Timer = MainTitle:Clone() Timer.Parent = Background
Body.Name = "Text" Body.Text = Message Body.Position = UDim2.new(0, 125, 0.5, -200) Body.Size = UDim2.new(1, -250, 0.5, 0) Body.Font = Enum.Font.SourceSansLight Body.TextScaled = false Body.FontSize = Enum.FontSize.Size28 Timer.Size = UDim2.new(0, 40, 0, 40) Timer.Text = Duration Timer.Name = "Timer" Timer.Position = UDim2.new(0.5, -20, 0, 40)
Background:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Bounce", 3) wait(3) coroutine.resume(coroutine.create(function() StartTimer(Timer) end)) wait(Duration) Background:TweenPosition(UDim2.new(2, 2, 0, 2), "In", "Bounce", 3) wait(3) MainGui:Destroy() end)()
end
function CreateHint(Message, Player, Duration)
local function StartTimer(TextLabel) for Number = Duration, 0, -1 do TextLabel.Text = Number wait(1) end end
coroutine.wrap(function()
if Player.PlayerGui:FindFirstChild("DHint") then Player.PlayerGui["DHint"]:Destroy() end
local MainGui = NewInstance("ScreenGui", Player.PlayerGui, "DHint") local Background = NewInstance("Frame", MainGui, "Background") local MainText = NewInstance("TextLabel", Background, "Text")
Background.Position = UDim2.new(0, 0, -1, 2) Background.Size = UDim2.new(1, 0, 0, 25) Background.BackgroundColor3 = Color3.fromRGB(32, 32, 32) Background.BackgroundTransparency = 0.5 Background.BorderColor3 = Color3.fromRGB(255, 255, 255) Background.BorderSizePixel = 2 MainText.BackgroundTransparency = 1 MainText.Position = UDim2.new(0, 205, 0, 0) MainText.Size = UDim2.new(1, -410, 1, 0) MainText.Font = Enum.Font.SourceSansLight MainText.TextScaled = true MainText.TextWrapped = true MainText.TextYAlignment = Enum.TextYAlignment.Bottom MainText.TextColor3 = Color3.fromRGB(255, 255, 255) MainText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) MainText.TextStrokeTransparency = 0.6 MainText.Text = Message local Timer = MainText:Clone() Timer.Text = Duration Timer.Parent = Background Timer.Name = "Timer" Timer.Size = UDim2.new(0, 25, 0, 25) Timer.Position = UDim2.new(0.5, -15, 1, 0)
Background:TweenPosition(UDim2.new(0, 0, 0, 2), "Out", "Bounce", 3) wait(3) coroutine.resume(coroutine.create(function() StartTimer(Timer) end)) wait(Duration) Background:TweenPosition(UDim2.new(0, 0, 1, 2), "In", "Bounce", 3) wait(3) MainGui:Destroy() end)()
end
function GetPlayer(Message) for _, Player in pairs(Services.Players:GetChildren()) do if string.find(Player.Name:lower(), Message:lower()) then return Player end end end
function GrabPlayers(Speaker, Message)
local Players = {}
if Message:lower() == "others" then for _, Player in pairs(Services.Players:GetChildren()) do if Player.Name ~= Speaker.Name then table.insert(Players, Player) end end
elseif Message:lower() == "all" then Players = Services.Players:GetChildren()
else for Player in Message:gmatch("[^" .. Settings.Splitter .. "]+") do
local Plr = GetPlayer(Player)
if Player:lower() == "me" then Players = {Speaker}
elseif Player:lower() == "random" then local Plrs = Services.Players:GetChildren() table.insert(Players, Plrs[math.random(0, #Plrs)])
elseif Plr then Players[#Players + 1] = Plr
end
end
end
return Players
end
function CheckBannedGears(Message) for _, ID in pairs(Settings.BannedGears) do if tostring(Message):lower():find(tostring(ID)) then return true end end end
function ToASCII(Message) local Converted = "" for Convert in Message:gmatch("[%w%s%p%d]") do Converted = Converted .. string.byte(Convert, #Convert) .. " " end Converted = Converted:sub(0, #Converted - 1) return Converted end
function ToChar(Message) local Converted = "" for Convert in Message:gmatch("[%d]+") do Converted = Converted .. string.char(Convert) end return Converted end
function ToBinary(Message) local Converted = "" local function ConvertCharacter(Integer, BaseInteger) local Base, Keys, Out, Decimal = BaseInteger or 10, "01", "" for Loop = 1, 8 do Integer, Decimal = math.floor(Integer / Base), math.fmod(Integer, Base) + 1 Out = string.sub(Keys, Decimal, Decimal) .. Out end return Out end for Convert in Message:gmatch("[%w%s%p%d]") do Converted = Converted .. (ConvertCharacter(string.byte(Convert), 2)) .. " " end Converted = Converted:sub(0, #Converted - 1) return Converted end
function BinaryToChar(Message) local Converted = "" for Convert in Message:gmatch("[%d]+") do Converted = Converted .. string.char(tonumber(Convert, 2)) end return Converted end
function ToHex(Message) local Converted = "" for Convert in Message:gmatch("[%w%s%p%d]") do Convert = string.byte(Convert) if (tostring(Convert):match("%d+")) then Converted = Converted .. ("%X"):format(tostring(Convert)) .. " " end end Converted = Converted:sub(0, #Converted - 1) return Converted end
function HexToChar(Message) local Converted = "" for Convert in Message:gmatch("[%d%a]+") do if (Convert:match("[%d%a]")) then Converted = Converted .. string.char(tonumber(Convert, 16)) end end return Converted end
function ToOctal(Message) local Converted = "" for Convert in Message:gmatch("[%w%s%p%d]") do Convert = string.byte(Convert) if (tostring(Convert):match("[%d%a]")) then if tonumber(("%o"):format(tostring(Convert))) < 100 then Converted = Converted .. 0 .. ("%o"):format(tostring(Convert)) .. " " else Converted = Converted .. ("%o"):format(tostring(Convert)) .. " " end end end Converted = Converted:sub(0, #Converted - 1) return Converted end
function OctalToChar(Message) local Converted = "" for Convert in Message:gmatch("[%d%a]+") do Convert = tostring(Convert) if (Convert:match("[%d%a]")) then Converted = Converted .. string.char(tonumber(Convert, 8)) end end return Converted end

function CreateSound(Name, Parent, ID, Pitch, Volume) if not Parent:FindFirstChild(Name) then local Sound = NewInstance("Sound", Parent, Name) Sound.SoundId = "rbxassetid://" .. ID Sound.Pitch = Pitch Sound.Volume = Volume Sound.Looped = true Sound:Play() elseif Parent:FindFirstChild(Name) then Parent[Name]:Destroy() CreateSound(Name, Parent, ID, Pitch, Volume) end end

local ServerLocked = false

function AdminCommands(Message, Player)
if Message:lower() == "clean" then for _, Object in pairs(game.Workspace:GetChildren()) do if Object:IsA("Hat") or Object:IsA("Accessory") or Object:IsA("Tool") or Object:IsA("HopperBin") then Object:Destroy() end end end
--if Message:lower() == "clr" then for _, Player in pairs(Services.Players:GetChildren()) do for _, Object in pairs(Player.PlayerGui:GetChildren()) do if Object:IsA("ScreenGui") and Object.Name == "DMessage" or Object.Name == "DHint" then Object:Destroy() end end end
local function CheckPrefix(Msg) if Msg:sub(0, #Settings.Prefix) == Settings.Prefix then return true end end
local function CreateCommand(CommandName, Msg) if Msg:lower() == CommandName:lower() then return true end end
local function CheckCommand(CommandName, Msg, Enabled) if not Enabled then if not CheckOwner(Player) then CreateMessage("Disabled command!", "This command has been disabled by the game owner!", Player, 10) return end end for _, Argument in pairs(CommandName) do if Msg:lower() == Argument:lower() then return true end end end
if CheckPrefix(Message) then Message = Message:sub(1 + #Settings.Prefix, #Message)
local Spoken = {} Message:gsub("%S+", function(Word) table.insert(Spoken, Word) end)

--[[-------------------

	Normal Commands
	¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
-------------------]]--
--[[ Custom commands:
if CheckCommand({"commandname"}, Spoken[1], true means enabled || false means disabled) then print("Command works!") end																				--]]
	
if CheckCommand({"m", "msg", "message"}, Spoken[1], true) then for _, Plr in pairs(Services.Players:GetChildren()) do CreateMessage("Message from: " .. Player.Name, Message:match("[%S+]*(.+)$"):sub(2), Plr, 15) end end
if CheckCommand({"pm", "pmsg", "pmessage", "privatem", "privatemsg", "privatemessage"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do CreateMessage("Message from: " .. Player.Name, Message:match("[%S+]*(.+)$"):sub(#Spoken[2] + 2), Plr, 15) end end
if CheckCommand({"tm", "tmsg", "tmessage", "timedm", "timedmsg", "timedmessage"}, Spoken[1], true) then local Timer = tonumber(Spoken[2]) if type(Timer) ~= "number" then Timer = 15 else if Timer < 0 then Timer = 15 elseif Timer >= 120 then Timer = 120 end end for _, Plr in pairs(Services.Players:GetChildren()) do CreateMessage("Message from: " .. Player.Name, Message:match("[%S+]*(.+)$"):sub(#Spoken[2] + 2), Plr, Timer) end end
if CheckCommand({"h", "hint"}, Spoken[1], true) then for _, Plr in pairs(Services.Players:GetChildren()) do CreateHint(Player.Name.. ": " .. Message:match("[%S+]*(.+)$"):sub(2), Plr, 10) end end
if CheckCommand({"ph", "phint", "privateh", "privatehint"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do CreateHint("Hint from " .. Player.Name .. ": " ..  Message:match("[%S+]*(.+)$"):sub(#Spoken[2] + 2), Plr, 10) end end

if CheckCommand({"kill", "breakjoints", "rekt"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do coroutine.resume(coroutine.create(function() Plr.Character:BreakJoints() end)) end end
if CheckCommand({"respawn"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do coroutine.resume(coroutine.create(function() Plr:LoadCharacter() end)) end end
if CheckCommand({"debug", "refresh", "regen", "re", "d"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do coroutine.resume(coroutine.create(function() local Position = Plr.Character.Torso.Position wait() Plr:LoadCharacter() wait() Plr.Character:MoveTo(Position) end)) end end
if CheckCommand({"tp", "teleport"}, Spoken[1], true) then local Players, Plrs = GrabPlayers(Player, Spoken[2]), GrabPlayers(Player, Spoken[3]) for _, TPPlr in pairs(Players) do for _, ToPlr in pairs(Plrs) do TPPlr.Character:MoveTo(ToPlr.Character.Torso.Position) end end end
if CheckCommand({"to"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do Player.Character:MoveTo(Plr.Character.Torso.Position) end end

if CheckCommand({"forcefield", "ff"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do if not Plr.Character:FindFirstChild("DForceField") then NewInstance("ForceField", Plr.Character, "DForceField") end end end
--if CheckCommand({"char", "character"}, Spoken[1], true) then local Char = Spoken[3] end

--[[----------------
	
	Fun Commands
    ¯¯¯¯¯¯¯¯¯¯¯¯
----------------]]--

if Settings.FunCommands then
if CheckCommand({"toascii"}, Spoken[1], true) then local ToConvert = Message:match("[%S+]*(.+)$"):sub(2) CreateMessage("Text to ASCII conversion:", ToASCII(ToConvert), Player, 15) end
if CheckCommand({"tobinary"}, Spoken[1], true) then local ToConvert = Message:match("[%S+]*(.+)$"):sub(2) CreateMessage("Text to Binary conversion:", ToBinary(ToConvert), Player, 15) end
if CheckCommand({"tohex"}, Spoken[1], true) then local ToConvert = Message:match("[%S+]*(.+)$"):sub(2) CreateMessage("Text to Hex conversion:", ToHex(ToConvert), Player, 15) end
if CheckCommand({"tooctal"}, Spoken[1], true) then local ToConvert = Message:match("[%S+]*(.+)$"):sub(2) CreateMessage("Text to Octal conversion:", ToOctal(ToConvert), Player, 15) end

if CheckCommand({"music", "sound"}, Spoken[1], true) then CreateSound("DMusic", game.Workspace, Spoken[2], 1, 1) end
if CheckCommand({"pitch"}, Spoken[1], true) then local Sound = game.Workspace:FindFirstChild("DMusic") if Sound then Sound.Pitch = Spoken[2] end end
if CheckCommand({"volume"}, Spoken[1], true) then local Sound = game.Workspace:FindFirstChild("DMusic") if Sound then Sound.Volume = Spoken[2] end end
if CheckCommand({"play"}, Spoken[1], true) then game.Workspace:FindFirstChild("DMusic"):Play() end
if CheckCommand({"resume"}, Spoken[1], true) then game.Workspace:FindFirstChild("DMusic"):Resume() end
if CheckCommand({"pause"}, Spoken[1], true) then game.Workspace:FindFirstChild("DMusic"):Pause() end
if CheckCommand({"stop"}, Spoken[1], true) then game.Workspace:FindFirstChild("DMusic"):Stop() end
if CheckCommand({"lmusic", "lsound", "localmusic", "localsound",}, Spoken[1], true) then CreateSound("DMusic", Player.Backpack, Spoken[2], 1, 1) end
if CheckCommand({"lpitch", "localpitch"}, Spoken[1], true) then local Sound = Player.Backpack:FindFirstChild("DMusic") if Sound then Sound.Pitch = Spoken[2] end end
if CheckCommand({"lvolume", "localvolume"}, Spoken[1], true) then local Sound = Player.Backpack:FindFirstChild("DMusic") if Sound then Sound.Volume = Spoken[2] end end
if CheckCommand({"lplay", "localplay"}, Spoken[1], true) then Player.Backpack:FindFirstChild("DMusic"):Play() end
if CheckCommand({"lresume", "localresume"}, Spoken[1], true) then Player.Backpack:FindFirstChild("DMusic"):Resume() end
if CheckCommand({"lpause", "localpause"}, Spoken[1], true) then Player.Backpack:FindFirstChild("DMusic"):Pause() end
if CheckCommand({"lstop", "localstop"}, Spoken[1], true) then Player.Backpack:FindFirstChild("DMusic"):Stop() end

if CheckCommand({"shirt"}, Spoken[1], true) then local Asset = tonumber(Spoken[3]) if type(Asset) ~= "number" then CreateMessage("Invalid ID!", "Your input was not a valid shirt.", Player, 10) return else repeat wait() if Services.MarketplaceService:GetProductInfo(Asset).AssetTypeId ~= 1 then Asset = Asset - 1 end until Services.MarketplaceService:GetProductInfo(Asset).AssetTypeId == 1 local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do if Plr.Character:FindFirstChild("Shirt") or Plr.Character:FindFirstChild("DShirt") then for _, Obj in pairs(Plr.Character:GetChildren()) do if Obj:IsA("Shirt") then Obj.Parent = Plr.Character.Torso end end end local Shirt = NewInstance("Shirt", Plr.Character, "DShirt") Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=" .. Asset end end end
if CheckCommand({"pants"}, Spoken[1], true) then local Asset = tonumber(Spoken[3]) if type(Asset) ~= "number" then CreateMessage("Invalid ID!", "Your input was not a valid pant.", Player, 10) return else repeat wait() if Services.MarketplaceService:GetProductInfo(Asset).AssetTypeId ~= 1 then Asset = Asset - 1 end until Services.MarketplaceService:GetProductInfo(Asset).AssetTypeId == 1 local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do if Plr.Character:FindFirstChild("Pants") or Plr.Character:FindFirstChild("DPants") then for _, Obj in pairs(Plr.Character:GetChildren()) do if Obj:IsA("Pants") then Obj.Parent = Plr.Character.Torso end end end local Pants = NewInstance("Pants", Plr.Character, "DPants") Pants.PantsTemplate = "http://www.roblox.com/asset/?id=" .. Asset end end end
if CheckCommand({"tshirt"}, Spoken[1], true) then local Asset = tonumber(Spoken[3]) if type(Asset) ~= "number" then CreateMessage("Invalid ID!", "Your input was not a valid tshirt.", Player, 10) return else repeat wait() if Services.MarketplaceService:GetProductInfo(Asset).AssetTypeId ~= 1 then Asset = Asset - 1 end until Services.MarketplaceService:GetProductInfo(Asset).AssetTypeId == 1 local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do if Plr.Character:FindFirstChild("ShirtGraphic") or Plr.Character:FindFirstChild("DShirtGraphic") then for _, Obj in pairs(Plr.Character:GetChildren()) do if Obj:IsA("ShirtGraphic") then Obj.Parent = Plr.Character.Torso end end end local Shirt = NewInstance("ShirtGraphic", Plr.Character, "DShirtGraphic") Shirt.Graphic = "http://www.roblox.com/asset/?id=" .. Asset end end end
if CheckCommand({"hat", "accessory"}, Spoken[1], true) then local Asset = tonumber(Spoken[3]) if type(Asset) ~= "number" then CreateMessage("Invalid ID!", "Your input was not a valid hat.", Player, 10) return else local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do local Object = Services.InsertService:LoadAsset(Asset) for _, Obj in pairs(Object:GetChildren()) do if Obj:IsA("Hat") or Obj:IsA("Accessory") then Obj.Parent = Plr.Character end end Object:Destroy() end end end
if CheckCommand({"gear"}, Spoken[1], true) then local Asset = tonumber(Spoken[3]) if CheckBannedGears(Asset) then CreateMessage("BANNED GEAR!", "This gear has been restricted by the owner of this game.", Player, 10) return end if type(Asset) ~= "number" then CreateMessage("Invalid ID!", "Your input was not a valid gear.", Player, 10) return else local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do local Object = Services.InsertService:LoadAsset(Asset) for _, Obj in pairs(Object:GetChildren()) do if Obj:IsA("Tool") or Obj:IsA("HopperBin") then Obj.Parent = Plr.Backpack end end Object:Destroy() end end end

end

--[[------------------
	
	Owner Commands
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
------------------]]--

if CheckOwner(Player) then
if CheckCommand({"kick"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do if Plr.Name ~= Player.Name or CheckOwner(Player) then Plr:Kick("You have been kicked from the game.") end end end
if CheckCommand({"ban"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do if Plr.Name ~= Player.Name or CheckOwner(Player) then table.insert(Banned, Plr.Name) Plr:Kick("You have been banned from the game.") end end end
if CheckCommand({"sm"}, Spoken[1], true) then for _, Plr in pairs(Services.Players:GetChildren()) do CreateMessage("SYSTEM MESSAGE!", Message:match("[%S+]*(.+)$"):sub(2), Plr, 15) end end

if CheckCommand({"admin"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do table.insert(Admins, Plr.Name) OnEntrance(Plr) end end
if CheckCommand({"owner"}, Spoken[1], true) then local Players = GrabPlayers(Player, Spoken[2]) for _, Plr in pairs(Players) do table.insert(Owners, Plr.Name) OnEntrance(Plr) end end
-- More
end
end
end

--[[---------------
	
	Other stuff
    ¯¯¯¯¯¯¯¯¯¯¯
---------------]]--

function OnEntrance(Player)
if Settings.FreeAdmin then for _, Plr in pairs(Services.Players:GetChildren()) do if not CheckAdmin(Plr) or not CheckOwner(Plr) then table.insert(Admins, Plr.Name) end end end
if CheckBanned(Player) and not CheckOwner(Player) then Player:Kick("You are banned from entering this game.") end if CheckVIP(Player) then table.insert(Admins, Player.Name) end wait()
if CheckAdmin(Player) or CheckOwner(Player) then CreateMessage("DurstAuric's Admin Commands", "You're an " .. string.lower(GetRank(Player)) .. "!", Player, 10)
Player.Chatted:connect(function(Message) AdminCommands(Message, Player) end)
end
end
for _, Player in pairs(Services.Players:GetChildren()) do OnEntrance(Player) end
Services.Players.PlayerAdded:connect(OnEntrance)
--print(script.Name .. ". Version: " .. script.Version.Value)
