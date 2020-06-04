local Services = {Players = game:GetService("Players"), RunService = game:GetService("RunService"), UserInputService = game:GetService("UserInputService"),} local Functions = {}
local States = {["WallClimb"] = false, ["Remainder"] = nil,}
local Shift = {[Enum.KeyCode.LeftShift] = false}
local Settings = {ClimbSpeed = 25, Distance = 1.5,}
Functions.NewInstance = function(Type, Name, Parent)
if Name == nil and Parent == nil then return Instance.new(Type, script)
elseif type(Name) == "userdata" and Parent == nil then return Instance.new(Type, Name)
else local NIns = Instance.new(Type, Parent) NIns.Name = Name return NIns end end
local Animation1 = Functions.NewInstance("Animation") Animation1.AnimationId = "http://www.roblox.com/Asset?ID=585529947" Animation1 = Services.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Animation1)
local Animation2 = Functions.NewInstance("Animation") Animation2.AnimationId = "http://www.roblox.com/Asset?ID=599879466" Animation2 = Services.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Animation2)
local Vel = Instance.new("BodyVelocity", Services.Players.LocalPlayer.Character.HumanoidRootPart) Vel.velocity = Vector3.new(0, Settings.ClimbSpeed, 0) Vel.maxForce = Vector3.new(0, 0, 0)
Functions.CastRay = function(Object)
local NewRay = Ray.new(Object.Position - Vector3.new(0, 3.5, 0), Object.CFrame.lookVector * Settings.Distance)
local Part, Position = game.Workspace:FindPartOnRay(NewRay, Object, false, true)
if Part == nil then return false else
local Difference = Position - Part.Position
local RelativePosition = (Part.Size - Vector3.new(0, Part.Size.Y / 2, 0)) + Difference
local Remainder = Part.Size.Y - RelativePosition.Y
NewRay = Ray.new(Object.Position, (Vector3.new(0, Remainder, 0) - Object.Position).unit * Remainder)
return NewRay, math.ceil(Remainder) end
end 
Services.RunService.RenderStepped:connect(function()
if not Animation1.IsPlaying and States["WallClimb"] then Animation1:Play() else end
if Services.Players.LocalPlayer.Character.Humanoid.Jump then
if Shift[Enum.KeyCode.LeftShift] then if States["WallClimb"] then
local CurrentRay, Remainder = Functions.CastRay(Services.Players.LocalPlayer.Character.HumanoidRootPart) States["Remainder"] = Remainder
if CurrentRay then Vel.maxForce = Vector3.new(0, 10 ^ 5, 0) if Remainder <= 1 or Remainder + 1 <= 1 or Remainder - 1 <= 1 then Vel.maxForce = Vector3.new(0, 0, 0) Animation1:Stop() end
elseif not CurrentRay and States["WallClimb"] and Remainder == nil then Vel.maxForce = Vector3.new(0, 0, 0) Animation1:Stop()
elseif CurrentRay and not States["WallClimb"] then Vel.maxForce = Vector3.new(0, 0, 0) Animation1:Stop()
end end
elseif not Shift[Enum.KeyCode.LeftShift] then
return end
end end)
Services.UserInputService.InputBegan:connect(function(Input, GameEvent)
if not GameEvent then
if Shift[Input.KeyCode] == false and not States["WallClimb"] and Services.Players.LocalPlayer.Character.Humanoid.Jump then
Shift[Input.KeyCode] = true States["WallClimb"] = true
spawn(function() while wait() do if States["Remainder"] == nil then States["WallClimb"] = false Vel.maxForce = Vector3.new(0, 0, 0) Animation1:Stop() end end end)
end end end)
Services.UserInputService.InputEnded:connect(function(Input)
if Shift[Input.KeyCode] == true then
if States["WallClimb"] then Shift[Input.KeyCode] = false States["WallClimb"] = false Vel.maxForce = Vector3.new(0, 0, 0) Animation1:Stop() Animation2:Play()
elseif not States["WallClimb"] then Shift[Input.KeyCode] = false Vel.maxForce = Vector3.new(0, 0, 0) Animation1:Stop()
end end end)
