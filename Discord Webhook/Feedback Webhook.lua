																																																						--[[
-=[ -
	
	- PLEASE ENABLE HTTPSERVICE FOR THIS TO WORK! -
	Feedback Webkhook for Discord, created & scripted by DurstAuric.
	Anything you should need to change will be in the "Settings" module inside of this script.
	This will not work in Studio -- this runs off of a private module -- but the module will be free!
	This is so I can press out updates without anyone having to re-insert this script into their places.
	
	If you don't own a copy of this script, I advise that you take a copy -- this is so it can be re-inserted if
	something was incorrect within the script.
	You may take a copy here: https://www.roblox.com/item.aspx?id=569608735
	You may take a copy of the MainModule here: https://www.roblox.com/item.aspx?id=569692340
	
																									~ DurstAuric
	
- ]=-																																																					--]] -- Nothing to see past here. Just moving these out of the way
if script.Name ~= "Feedback Webhook" and not script:FindFirstChild("Settings") then -- Checks to see if anything is incorrect.
local Script = game:GetService("InsertService"):LoadAsset(569608735) Script["Feedback Webhook"].Parent = game:GetService("ServerScriptService") Script:Destroy() script:Destroy()
elseif not script:FindFirstChild("Settings") then
local Script = game:GetService("InsertService"):LoadAsset(569608735) Script["Feedback Webhook"]:FindFirstChild("Settings").Parent = script Script:Destroy()
elseif script.Parent ~= game:GetService("ServerScriptService") then script.Parent = game:GetService("ServerScriptService")
end while require(569692340) ~= nil do wait() end -- Performs a check to make sure something is being returned from the module.
