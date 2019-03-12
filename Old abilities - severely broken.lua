--=[ - Services - ]=--
local Services = {
	PlayerService = game:GetService("Players");
	InputService = game:GetService("UserInputService");
	ActionService = game:GetService("ContextActionService");
	RunService = game:GetService("RunService");
}
--=[ - Action States - ]=--
local States = {
	["MidAir"] = false;
	["ChargingJump"] = false;
	["Gliding"] = false;
	["Sprinting"] = false;
	["AirDash"] = false;
	["Consuming"] = false;
	["ConsumedAppearance"] = false;
	["LightActive"] =  false;
	["ConsumeGui"] = false;
}
--=[ - Settings - ]=--
local Settings = {
	JumpHeight = 50;
	JumpHeightLimit = 200;
	WalkSpeed = 16;
	WalkSpeedLimit = 50;
	SprintSpeed = 80;
	EqualisingForce = 236 / 1.2;
	ForceLimit = 85;
	Gravity = 0.425;
	DashLimit = 2;
}
--=[ - Keys - ]=--
-- Charge jump.
local Key = {
	[Enum.KeyCode.Space] = false;
}
-- Sprint / glide.
local Key2 = {
	[Enum.KeyCode.LeftShift] = false;
}
-- 'Temporary' consume.
local Key3 = {
	[Enum.KeyCode.E] = false;
}
-- 'Temporary' disguise.
local Key4 = {
	[Enum.KeyCode.F] = false;
}
-- 'Temporary' light.
local Key5 = {
	[Enum.KeyCode.L] = false;
}
--=[ - Animations - ]=--
local Animations = {
	ChargingJump = "http://www.roblox.com/Asset?ID=346933059";
	LandedJump = "http://www.roblox.com/Asset?ID=346941183";
	Falling = "http://www.roblox.com/Asset?ID=356796891";
	Gliding = "http://www.roblox.com/Asset?ID=357143748";
}
--=[ - Miscellaneous - ]=--
local Misc = {
	Player = Services["PlayerService"].LocalPlayer;
	Character = Services["PlayerService"].LocalPlayer.Character;
	Camera = game.Workspace.CurrentCamera;
	Debounce = false;
	Debounce2 = false;
	Debounce3 = false;
	Loaded = false;
}
repeat wait() until Misc.Player.Character
Misc.Player.Character.Animate.fall.FallAnim.AnimationId = Animations["Falling"]
local ChargeJumpAniHandler = Instance.new("Animation", script)
	ChargeJumpAniHandler.Name = "ChargeJumpAnimation"
	ChargeJumpAniHandler.AnimationId = Animations["ChargingJump"]
	ChargeJumpAnimation = Misc.Player.Character.Humanoid:LoadAnimation(ChargeJumpAniHandler)
local LandJumpAniHandler = Instance.new("Animation", script)
	LandJumpAniHandler.Name = "LandJumpAnimation"
	LandJumpAniHandler.AnimationId = Animations["LandedJump"]
	LandJumpAnimation = Misc.Player.Character.Humanoid:LoadAnimation(LandJumpAniHandler)
local GlideAniHandler = Instance.new("Animation", script)
	GlideAniHandler.Name = "GlideAnimation"
	GlideAniHandler.AnimationId = Animations["Gliding"]
	GlideAnimation = Misc.Player.Character.Humanoid:LoadAnimation(GlideAniHandler)
local BForce = Instance.new("BodyVelocity")
	BForce.Parent = Misc.Player.Character.HumanoidRootPart
	BForce.Name = "Glide"
	BForce.MaxForce = Vector3.new(0, 0, 0)
	BForce.Velocity = Vector3.new(0, 0, 0)
local BVelocity = Instance.new("BodyVelocity")
	BVelocity.Parent = Misc.Player.Character.Torso
	BVelocity.Name = "Dash"
	BVelocity.MaxForce = Vector3.new(0, 0, 0)
	BVelocity.Velocity = Vector3.new(0, 0, 0)
local PlayerHandler = Misc.Player.Backpack.PlayerHandler
	local Consumed = PlayerHandler.Consumed
	local Outfit = PlayerHandler.Outfit
local PlayerHUD = Misc.Player.PlayerGui:WaitForChild("PlayerHUD")
	local ConsumePlayer = PlayerHUD.Mainframe.ConsumeName
local LightEmitter = Instance.new("PointLight")
	LightEmitter.Parent = Misc.Player.Character.Torso
	LightEmitter.Range = 12
	LightEmitter.Color = Color3.new(1, 0, 0)
	LightEmitter.Shadows = true
	LightEmitter.Enabled = false
Misc.Player.CharacterAppearanceLoaded:connect(function()
	coroutine.wrap(function()
		for _,Part in pairs(Misc.Player.Character:GetChildren()) do
			if Part:IsA("BasePart") then
				if Part.Name == "Left Arm" then
					local Fire = game:GetService("ReplicatedStorage").Fire:Clone()
					Fire.Parent = Part
					Fire.Enabled = false
				end
				if Part.Name == "Right Arm" then
					local Fire = game:GetService("ReplicatedStorage").Fire:Clone()
					Fire.Parent = Part
					Fire.Enabled = false
				end
				if Part.Name == "Left Leg" then
					local Fire = game:GetService("ReplicatedStorage").Fire:Clone()
					Fire.Parent = Part
					Fire.Enabled = false
				end
				if Part.Name == "Right Leg" then
					local Fire = game:GetService("ReplicatedStorage").Fire:Clone()
					Fire.Parent = Part
					Fire.Enabled = false
				end
			end
			if Part.ClassName == "BodyColors" then
				local PartClone = Part:Clone()
				PartClone.Parent = Outfit
			end
			if Part.ClassName == "Shirt" then
				local PartClone = Part:Clone()
				PartClone.Parent = Outfit
			end
			if Part.ClassName == "Pants" then
				local PartClone = Part:Clone()
				PartClone.Parent = Outfit
			end
			if Part.ClassName == "Accessory" or Part.ClassName == "Hat" then
				local PartClone = Part:Clone()
				PartClone.Parent = Outfit
			end
			if Part.Name == "Head" then
				for _,Obj in pairs(Part:GetChildren()) do
					if Obj:IsA("Decal") and Obj.Name == "face" then -- Face
						local ObjClone = Obj:Clone()
						ObjClone.Parent = Outfit
					end
					if Obj.ClassName == "SpecialMesh" then -- Head mesh, just in case they're wearing a different head.
						local ObjClone = Obj:Clone()
						ObjClone.Parent = Outfit
					end
				end
			end
			if Part.ClassName == "CharacterMesh" then -- Packages
				local PartClone = Part:Clone()
				PartClone.Parent = Outfit
			end
		end
	end)()
	Misc.Loaded = true
	while Misc.Loaded do
		wait()
	end
end)
Misc.Player.Character.Humanoid.StateChanged:connect(function(Old, New)
	if New == Enum.HumanoidStateType.Landed then
		if Misc.Player.Character.Torso.Velocity.Y < 1 then
			if States["MidAir"] then
				States["MidAir"] = false
			end
			Misc.Debounce = false
			BVelocity.MaxForce = Vector3.new(0, 0, 0)
			BVelocity.Velocity = Vector3.new(0, 0, 0)
			Settings.DashLimit = 2
			LandJumpAnimation:Play()
			Misc.Player.Character.Humanoid.JumpPower = 0
			if States["Gliding"] then
				States["Gliding"] = false
				BForce.MaxForce = Vector3.new(0, 0, 0)
				BForce.Velocity = Vector3.new(0, 0, 0)
				GlideAnimation:Stop()
			end
			for _,Part in pairs(Misc.Player.Character:GetChildren()) do
				if Part:IsA("BasePart") then repeat wait() until Misc.Player.Character.Torso:FindFirstChild("Fire")
					if Part.Name == "Left Arm" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
					if Part.Name == "Right Arm" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
					if Part.Name == "Left Leg" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
					if Part.Name == "Right Leg" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
				end
			end
			if States["Sprinting"] then
				Misc.Player.Character.Humanoid.WalkSpeed = Misc.Player.Character.Humanoid.WalkSpeed
				for _,Part in pairs(Misc.Player.Character:GetChildren()) do
					if Part:IsA("BasePart") then
						if Part.Name == "Left Arm" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Right Arm" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Left Leg" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Right Leg" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
					end
				end
			end
			if not States["Sprinting"] then
				Misc.Player.Character.Humanoid.WalkSpeed = 16
			end
		end
	end
	if New == Enum.HumanoidStateType.Jumping then
		States["MidAir"] = true
		for _,Part in pairs(Misc.Player.Character:GetChildren()) do
			if Part:IsA("BasePart") then
				if Part.Name == "Left Arm" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
				if Part.Name == "Right Arm" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
				if Part.Name == "Left Leg" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
				if Part.Name == "Right Leg" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
			end
		end
	end
	if New == Enum.HumanoidStateType.Freefall then
		States["MidAir"] = true
		for _,Part in pairs(Misc.Player.Character:GetChildren()) do
			if Part:IsA("BasePart") then
				if Part.Name == "Left Arm" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
				if Part.Name == "Right Arm" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
				if Part.Name == "Left Leg" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
				if Part.Name == "Right Leg" then
					local Fire = Part.Fire
					Fire.Parent = Part
					Fire.Enabled = true
				end
			end
		end
	end
end)
Services["RunService"].RenderStepped:connect(function()
	for _, Player in pairs(game.Workspace:GetChildren()) do
		if Player:IsA("Model") and Player.Name ~= Misc.Player.Name then
			if (Misc.Player.Character.Torso.Position - Player.Torso.Position).magnitude <= 5 then
				ConsumePlayer.Text = "Consume " .. Player.Name
				ConsumePlayer.Visible = true
			else
				ConsumePlayer.Visible = false
			end
		end
	end
end)
function ChargeJump()
	local function HumanoidUpdated()
		if Key[Enum.KeyCode.Space] then
			if Misc.Player.Character.Humanoid.Jump then
				Misc.Player.Character.Humanoid.Jump = false
			end
		end
	end
	if Misc.Player.Character.Humanoid.Changed:connect(HumanoidUpdated) then
		if not States["ChargingJump"] then
			States["ChargingJump"] = true
			repeat
				ChargeJumpAnimation:Play()
				for JumpHeight = 50, Settings.JumpHeightLimit do
					wait()
					Settings.JumpHeight = JumpHeight
					if JumpHeight == Settings.JumpHeightLimit then
						break
					end
					if not Key[Enum.KeyCode.Space] then
						break
					end
				end
			until not Key[Enum.KeyCode.Space] or Settings.JumpHeight == Settings.JumpHeightLimit
		end
	end
end
function Glide()
	local Children = Misc.Player.Character:GetChildren()
	local M = 0
	local Head = nil
	if (Misc.Player.Character:FindFirstChild("Head") ~= nil) then Head = Misc.Player.Character:FindFirstChild("Head") end
	if Key2[Enum.KeyCode.LeftShift] then
		if States["MidAir"] and not States["Gliding"] then
			if not Misc.Debounce then
				Misc.Debounce = true
				States["Gliding"] = true
				GlideAnimation:Play()
				Misc.Player.Character.Torso.Velocity = Vector3.new(Misc.Player.Character.Torso.Velocity.X, -1, Misc.Player.Character.Torso.Velocity.Z)
				for _,Part in pairs(Misc.Player.Character:GetChildren()) do
					if Part:IsA("BasePart") then
						if Part.Name == "Left Arm" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Right Arm" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Left Leg" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Right Leg" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
					end
				end
				BForce.MaxForce = Vector3.new(0, 4000, 0)
				BForce.Velocity = Vector3.new(0, -12, 0)
				for Speed = 16, Settings.WalkSpeedLimit do
					wait()
					Settings.WalkSpeed = Speed
					Misc.Player.Character.Humanoid.WalkSpeed = Speed
					if Speed == Settings.WalkSpeedLimit then
						break
					end
					if Key[Enum.KeyCode.LeftShift] == false then
						break
					end
				end
			end
		end
	end
end
function Sprint()
	if Key2[Enum.KeyCode.LeftShift] then
		if not States["MidAir"] and not States["Gliding"] then
			if not States["Sprinting"] then
				States["Sprinting"] = true
				for _,Part in pairs(Misc.Player.Character:GetChildren()) do
					if Part:IsA("BasePart") then
						if Part.Name == "Left Arm" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Right Arm" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Left Leg" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
						if Part.Name == "Right Leg" then
							local Fire = Part.Fire
							Fire.Parent = Part
							Fire.Enabled = true
						end
					end
				end
				for CameraView = 70, 90 do
					wait()
					Misc.Camera.FieldOfView = CameraView
					if CameraView == 90 then
						break
					end
				end
				for SprintSpeed = 16, Settings.SprintSpeed do
					wait()
					Misc.Player.Character.Humanoid.WalkSpeed = SprintSpeed
					if SprintSpeed == Settings.SprintSpeed then
						break
					end
					if Key2[Enum.KeyCode.LeftShift] == false then
						break
					end
				end
			end
		end
	end
end
function AirDash()
	repeat 
		wait()
		if Key[Enum.KeyCode.Space] then
			if States["MidAir"] and States["Gliding"] and not States["ChargingJump"] then				
				if Settings.DashLimit > 0 then
				if not States["AirDash"] then
					if not Misc.Debounce2 then
						States["AirDash"] = true
						Misc.Debounce2 = true
						Settings.DashLimit = Settings.DashLimit - 1
						Misc.Player.Character.Torso.Velocity = Vector3.new(Misc.Player.Character.Torso.Velocity.X, 0, Misc.Player.Character.Torso.Velocity.Z)
						BVelocity.MaxForce = Vector3.new(10000, 0, 10000)
						BVelocity.P = 50000
						BVelocity.Velocity = Vector3.new(Misc.Player.Character.HumanoidRootPart.Velocity.X * 20, 0, Misc.Player.Character.HumanoidRootPart.Velocity.Z * 20)						
						wait(.2)
						BVelocity.Velocity = Vector3.new(0, 0, 0)
						BVelocity.MaxForce = Vector3.new(0, 0, 0)
						Key[Enum.KeyCode.Space] = false
						States["AirDash"] = false
						Misc.Debounce2 = false
					end
				end
			end	
		end
	end	
	until Settings.DashLimit <= 0
end
function Consume()
	if Key3[Enum.KeyCode.E] then
		if not States["Consuming"] then
			States["Consuming"] = true
			local PlayerHumanoid = Misc.Player.Character.Humanoid
			for _,Player in pairs(game.Workspace:GetChildren()) do
				if Player:IsA("Model") and Player.Name ~= Misc.Player.Name then
					for _,Humanoid in pairs(Player:GetChildren()) do
						if Humanoid:IsA("Humanoid") and Humanoid ~= PlayerHumanoid then
							if (Misc.Player.Character.Torso.Position - Player.Torso.Position).magnitude < 5 then
								for _,Obj in pairs(Consumed:GetChildren()) do
									Obj:Destroy()
								end
								for _,Obj in pairs(Humanoid.Parent:GetChildren()) do
									if Obj.ClassName == "BodyColors" then
										local ObjClone = Obj:Clone()
										ObjClone.Parent = Consumed
									end
									if Obj.ClassName == "Shirt" then
										local ObjClone = Obj:Clone()
										ObjClone.Parent = Consumed
									end
									if Obj.ClassName == "Pants" then
										local ObjClone = Obj:Clone()
										ObjClone.Parent = Consumed
									end
									if Obj.ClassName == "Accessory" or Obj.ClassName == "Hat" then
										local ObjClone = Obj:Clone()
										ObjClone.Parent = Consumed
									end
									if Obj.Name == "Head" then
										for _,Child in pairs(Obj:GetChildren()) do
											if Child.ClassName == "Decal" and Child.Name == "face" then -- Face
												local ObjClone = Child:Clone()
												ObjClone.Parent = Consumed
											end
											if Child.ClassName == "SpecialMesh" then -- Head mesh, just in case they're wearing a different head.
												local ObjClone = Child:Clone()
												ObjClone.Parent = Consumed
											end
										end
									end
									if Obj.ClassName == "CharacterMesh" then -- Packages
										local PartClone = Obj:Clone()
										PartClone.Parent = Consumed
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
function ConsumedAppearance()
	if Key4[Enum.KeyCode.F] then
		if not States["ConsumedAppearance"] then
			if not Misc.Debounce2 then
				Misc.Debounce2 = true
				for _,Obj in pairs(Misc.Player.Character:GetChildren()) do
					if Obj.ClassName == "BodyColors" then
						Obj:Destroy()
					end
					if Obj.ClassName == "Shirt" then
						Obj:Destroy()
					end
					if Obj.ClassName == "Pants" then
						Obj:Destroy()
					end
					if Obj.ClassName == "Accessory" or Obj.ClassName == "Hat" then
						Obj:Destroy()
					end
					if Obj.Name == "Head" then
						for _,Child in pairs(Obj:GetChildren()) do
							if Child.ClassName == "Decal" then
								Child:Destroy()
							end
							if Child.ClassName == "SpecialMesh" then
								Child:Destroy()
							end
						end
					end
					if Obj.ClassName == "CharacterMesh" then
						Obj:Destroy()
					end
				end
				for _,Obj in pairs(Consumed:GetChildren()) do
					if Obj.ClassName == "BodyColors" then
						Obj.Parent = Misc.Player.Character
					end
					if Obj.ClassName == "Pants" then
						Obj.Parent = Misc.Player.Character
					end
					if Obj.ClassName == "Shirt" then
						Obj.Parent = Misc.Player.Character
					end
					if Obj.ClassName == "Accessory" then
						Misc.Player.Character.Humanoid:AddAccessory(Obj)
					end
					if Obj.ClassName == "Hat" then
						Obj.Parent = Misc.Player.Character
					end
					if Obj.Name == "Mesh" then
						Obj.Parent = Misc.Player.Character.Head
					end
					if Obj.Name == "face" then
						Obj.Parent = Misc.Player.Character.Head
					end
					if Obj.ClassName == "CharacterMesh" then
						Obj.Parent = Misc.Player.Character
					end
				end
				Misc.Debounce2 = false
			end
		end
	end
end
function PlayerAppearance()
	if Key4[Enum.KeyCode.F] then
		if States["ConsumedAppearance"] then
			if not Misc.Debounce2 then
				Misc.Debounce2 = true
				for _,Obj in pairs(Misc.Player.Character:GetChildren()) do
					if Obj.ClassName == "BodyColors" then
						Obj.Parent = Consumed
					end
					if Obj.ClassName == "Pants" then
						Obj.Parent = Consumed
					end
					if Obj.ClassName == "Shirt" then
						Obj.Parent = Consumed
					end
					if Obj.ClassName == "Accessory" or Obj.ClassName == "Hat" then
						Obj.Parent = Consumed
					end
					if Obj.Name == "Head" then
						for _,Child in pairs(Obj:GetChildren()) do
							if Child.ClassName == "SpecialMesh" then
								Child.Parent = Consumed
							end
							if Child.ClassName == "Decal" and Child.Name == "face" then
								Child.Parent = Consumed
							end
						end
					end
					if Obj.ClassName == "CharacterMesh" then
						Obj.Parent = Consumed
					end
				end
				for _,Obj in pairs(Outfit:GetChildren()) do
					if Obj.ClassName == "BodyColors" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character
					end
					if Obj.ClassName == "Pants" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character
					end
					if Obj.ClassName == "Shirt" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character
					end
					if Obj.ClassName == "Accessory" then
						local OutfitClone = Obj:Clone()
						Misc.Player.Character.Humanoid:AddAccessory(OutfitClone)
					end
					if Obj.ClassName == "Hat" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character
					end
					if Obj.Name == "Mesh" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character.Head
					end
					if Obj.ClassName == "Decal" and Obj.Name == "face" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character.Head
					end
					if Obj.ClassName == "CharacterMesh" then
						local OutfitClone = Obj:Clone()
						OutfitClone.Parent = Misc.Player.Character
					end
				end
			end
		end
	end
end
function EmitLight()
	if Key5[Enum.KeyCode.L] then
		if not States["LightActive"] then
			States["LightActive"] = true
			LightEmitter.Enabled = true
			Key5[Enum.KeyCode.L] = false
		end
	end
end
Services["InputService"].InputBegan:connect(function(InputObject, GameEvent)
	if not GameEvent then
		if Key[InputObject.KeyCode] == false then
			if not States["ChargingJump"] and not States["MidAir"] then
				Key[InputObject.KeyCode] = true
				ChargeJump()
			end
			if not States["ChargingJump"] then
				if States["MidAir"] and States["Gliding"] then
					Key[InputObject.KeyCode] = true
					AirDash()
				end
			end
		end
	end
end)
Services["InputService"].InputEnded:connect(function(InputObject)
	if Key[InputObject.KeyCode] == true then
		Key[InputObject.KeyCode] = false
		States["ChargingJump"] = false
		if not States["ChargingJump"] then
			ChargeJumpAnimation:Stop()
		end
		Misc.Player.Character.Humanoid.JumpPower = Settings.JumpHeight
		Misc.Player.Character.Humanoid.Jump = true
		repeat wait() until States["MidAir"] == false
	end
end)
Services["InputService"].InputBegan:connect(function(InputObject, GameEvent)
	if not GameEvent then
		if Key2[InputObject.KeyCode] == false then
			if not States["ChargingJump"] and States["MidAir"] then
				Key2[InputObject.KeyCode] = true
				Glide()
			end
			if not States["ChargingJump"] and not States["MidAir"] then
				Key2[InputObject.KeyCode] = true
				Sprint()
			end
		end
	end
end)
Services["InputService"].InputEnded:connect(function(InputObject)
	if Key2[InputObject.KeyCode] == true then
		Key2[InputObject.KeyCode] = false
		if States["MidAir"] and States["Gliding"] then
			States["Gliding"] = false
			BForce.MaxForce = Vector3.new(0, 0, 0)
			BForce.Velocity = Vector3.new(0, 0, 0)
			GlideAnimation:Stop()
			Misc.Debounce = false
		end
		if States["MidAir"] then
			if States["Sprinting"] then
				States["Sprinting"] = false
					coroutine.wrap(function()
					for CameraView = 90, 70, -1 do
							wait()
							Misc.Camera.FieldOfView = CameraView
							if CameraView == 70 then
								break
							end
						end
					for SprintSpeed = Settings.SprintSpeed, 16, -1 do
						wait()
						Misc.Player.Character.Humanoid.WalkSpeed = SprintSpeed
						if SprintSpeed == 16 then
							break
						end
					end
				end)()
			end
		end
		Misc.Debounce3 = false
		if States["Sprinting"] then
			States["Sprinting"] = false
			coroutine.wrap(function()
				for CameraView = 90, 70, -1 do
						wait()
						Misc.Camera.FieldOfView = CameraView
						if CameraView == 70 then
							break
						end
					end
				for SprintSpeed = Settings.SprintSpeed, 16, -1 do
					wait()
					Misc.Player.Character.Humanoid.WalkSpeed = SprintSpeed
					if SprintSpeed == 16 then
						break
					end
				end
			end)()
			for _,Part in pairs(Misc.Player.Character:GetChildren()) do
				if Part:IsA("BasePart") then
					if Part.Name == "Left Arm" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
					if Part.Name == "Right Arm" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
					if Part.Name == "Left Leg" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
					if Part.Name == "Right Leg" then
						local Fire = Part.Fire
						Fire.Parent = Part
						Fire.Enabled = false
					end
				end
			end
		end
	end
end)
Services["InputService"].InputBegan:connect(function(InputObject, GameEvent)
	if not GameEvent then
		if Key3[InputObject.KeyCode] == false then
			if not States["Consuming"] then
				Key3[InputObject.KeyCode] = true
				Consume()
			end
		end
	end
end)
Services["InputService"].InputEnded:connect(function(InputObject)
	if Key3[InputObject.KeyCode] == true then
		if States["Consuming"] then
			States["Consuming"] = false
			Key3[InputObject.KeyCode] = false
		end
	end
end)
Services["InputService"].InputBegan:connect(function(InputObject, GameEvent)
	if not GameEvent then
		if Key4[InputObject.KeyCode] == false then
			if not States["ConsumedAppearance"] then
				Key4[InputObject.KeyCode] = true
				ConsumedAppearance()
				States["ConsumedAppearance"] = true
			elseif States["ConsumedAppearance"] then
				Key4[InputObject.KeyCode] = true
				PlayerAppearance()
				States["ConsumedAppearance"] = false
			end
		end
	end
end)
Services["InputService"].InputEnded:connect(function(InputObject)
	if Key4[InputObject.KeyCode] == true then
		Key4[InputObject.KeyCode] = false
		Misc.Debounce2 = false
	end
end)
Services["InputService"].InputBegan:connect(function(InputObject, GameEvent)
	if not GameEvent then
		if Key5[InputObject.KeyCode] == false then
			if not States["LightActive"] then
				Key5[InputObject.KeyCode] = true
				EmitLight()
			elseif States["LightActive"] then
				Key5[InputObject.KeyCode] = false
				LightEmitter.Enabled = false
				States["LightActive"] = false
			end
		end
	end
end)
