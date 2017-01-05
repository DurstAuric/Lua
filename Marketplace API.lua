																												--[[
						   MarketplaceService module // Scripted by DurstAuric
						   ---------------------------------------------------
	This module serves no real purpose, except to demonstrate how a more protected MarketplaceService
	might look like. The main purpose of this would have been to prevent those scam games, but the
	issue here is that the scammers would never decide to use this module. Like, seriously. If you
	don't know what I'm on about, then you may take a look for yourself here:
		
		* https://twitter.com/DurstAuric/status/813086763237470208
		
	I guess I could call this a way of showing how important this issue really is -- someone has to
	be the one to step out there and make a greater change. No-one likes a scammer! Anyway, I hope
	that one day this issue will be solved, bringing a greater peace to ROBLOX once more. Enjoy this
	module, I suppose. It has no use, but as I said; it's for a demonstration.
																						
																						 ~ DurstAuric
	
	-------------------------------------------------------------------------------------------------
	
	How this works:
	
	*	void PromptPurchase(
			Player player,
			int assetID,
			bool extraAuthenitcation,
			int waitDuration
		)
	
	*	void PromptProductPurchase(
			Player player,
			int assetID,
			bool or int extraAuthenitcation,
			int waitDuration
		)
	
	-------------------------------------------------------------------------------------------------
	
	The technical bits:
	
	- "bool extraAuthenication"
		Default value is false.
		If set to true by the developer, this allows a more secure purchase. It uses a check-box, which
		is a generic user-input option.
		
	- "int waitDuration"
		Default value is set to 3, and cannot be any lower.
		If supplied by the developer, this changes the wait duration before actually allowing the user
		to proceed the first time. Once the first dialog appears, this will take effect.
		Only works on the first dialog message, and not linked to "extraAuthentication".
		
	extraAuthentication can be a substitute for waitDuration, which allows the developer to configure
	the waitTime without needing the actual extraAuthentication bool.
	
	-------------------------------------------------------------------------------------------------
	
	Usage:
	
	-- Local script inside a TextButton.
	
	local MarketplaceService = require(ModuleID/ModuleLocation)
	
	script.Parent.MouseButton1Click:connect(function()
		MarketplaceService.PromptPurchase(game.Players.LocalPlayer, 116073713)
	end)
									
																												--]]
local Services = {
Players = game:GetService("Players"),
MarketplaceService = game:GetService("MarketplaceService"), -- You know, because _this_ still is needed because there's no other way to allow purchases without quite a few things. Which I don't know of. I'm not that smart. ecks dee memes!1!11
}
local MarketplaceService = {}
local Objects = {} local Functions = {} -- Storing my functions inside a table because I'm used to this. Plus this is good practice.
Functions.NewInstance = function(Type, Name, Parent) local NIns = Instance.new(Type, Parent) NIns.Name = Name return NIns end
Functions.CreateGui = function(Player, Type) -- To be honest, this makes up a lot of this script. To think that it would be easier to just create the gui and place it into the module. But no, I'm not doing that.
local MainGui = Functions.NewInstance("ScreenGui", "Authorisation", Player.PlayerGui)
if Type:lower() == "procan" then -- Proceed / cancel -- heck, why do you even need to know this? Sure, if you want to read the source then go ahead, but y'know.
local Mainframe = Functions.NewInstance("Frame", "Mainframe", MainGui)
Mainframe.Size = UDim2.new(0, 316, 0, 175) Mainframe.BackgroundColor3 = Color3.fromRGB(33, 33, 33) Mainframe.Position = UDim2.new(0.5, -158, -0.5, -86) Mainframe.BorderSizePixel = 0
local Title = Functions.NewInstance("TextLabel", "Title", Mainframe)
Title.Size = UDim2.new(1, 0, 0, 40) Title.Text = "Purchase request" Title.BackgroundTransparency = 1 Title.Font = Enum.Font.SourceSansItalic Title.FontSize = Enum.FontSize.Size28 Title.TextColor3 = Color3.fromRGB(255, 255, 255)
local Image = Functions.NewInstance("ImageLabel", "ItemImage", Mainframe)
Image.Size = UDim2.new(0, 60, 0, 60) Image.BorderSizePixel = 0 Image.Position = UDim2.new(0, 10, 0.5, -30) Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Image.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=$ID&width=100&height=100&format=png"
local Text = Title:Clone() -- I'm lazy, k? Like hell I'm going to do the same thing again. Takes up way too much time.
Text.Name = "Body" Text.Parent = Mainframe Text.Text = "A request to purchase $ITEM for $PRICE has been made. Would you like to allow it?" Text.Size = UDim2.new(0, 200, 0, 60) Text.Position = UDim2.new(1, -210, 0.5, -30) Text.TextWrapped = true Text.TextScaled = true
local SP1 = Functions.NewInstance("Frame", "Splitter", Mainframe)
SP1.Size = UDim2.new(1, -20, 0, 1) SP1.Position = UDim2.new(0, 10, 0, 45) SP1.BorderSizePixel = 0
local SP2 = SP1:Clone()
SP2.Parent = Mainframe SP2.Position = UDim2.new(0, 10, 0, 130)
local Proceed = Functions.NewInstance("TextButton", "Proceed", Mainframe)
Proceed.Text = "Proceed" Proceed.Size = UDim2.new(0.5, 0, 0, 40) Proceed.Position = UDim2.new(0, 0, 1, -40) Proceed.Font = Enum.Font.SourceSansBold Proceed.FontSize = Enum.FontSize.Size24 Proceed.TextColor3 = Color3.fromRGB(255, 255, 255) Proceed.Style = Enum.ButtonStyle.RobloxRoundButton Proceed.Active = false
local Cancel = Proceed:Clone()
Cancel.Name = "Cancel" Cancel.Text = "Cancel" Cancel.Parent = Mainframe Cancel.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Cancel.Position = UDim2.new(0.5, 0, 1, -40) Cancel.Active = true
elseif Type:lower() == "auth" then -- Authorisation, basically the optional option.
local Mainframe = Functions.NewInstance("Frame", "Mainframe", MainGui)
Mainframe.Size = UDim2.new(0, 316, 0, 175) Mainframe.BackgroundColor3 = Color3.fromRGB(33, 33, 33) Mainframe.Position = UDim2.new(0.5, -158, -0.5, -86) Mainframe.BorderSizePixel = 0
local Title = Functions.NewInstance("TextLabel", "Title", Mainframe)
Title.Size = UDim2.new(1, 0, 0, 40) Title.Text = "Authorise purchase" Title.BackgroundTransparency = 1 Title.Font = Enum.Font.SourceSansItalic Title.FontSize = Enum.FontSize.Size28 Title.TextColor3 = Color3.fromRGB(255, 255, 255)
local Text = Title:Clone()
Text.Name = "Body" Text.Parent = Mainframe Text.Text = "In order to complete the transaction for $ITEM, we need you to authorise the purchase. Price: $PRICE" Text.Size = UDim2.new(0, 230, 0, 60) Text.Position = UDim2.new(1, -245, 0.5, -30) Text.TextWrapped = true Text.TextScaled = true
local SP1 = Functions.NewInstance("Frame", "Splitter", Mainframe)
SP1.Size = UDim2.new(1, -20, 0, 1) SP1.Position = UDim2.new(0, 10, 0, 45) SP1.BorderSizePixel = 0
local SP2 = SP1:Clone()
SP2.Parent = Mainframe SP2.Position = UDim2.new(0, 10, 0, 130)
local Proceed = Functions.NewInstance("TextButton", "Proceed", Mainframe)
Proceed.Text = "Proceed" Proceed.Size = UDim2.new(0.5, 0, 0, 40) Proceed.Position = UDim2.new(0, 0, 1, -40) Proceed.Font = Enum.Font.SourceSansBold Proceed.FontSize = Enum.FontSize.Size24 Proceed.TextColor3 = Color3.fromRGB(255, 255, 255) Proceed.Style = Enum.ButtonStyle.RobloxRoundButton Proceed.Active = false
local Cancel = Proceed:Clone()
Cancel.Name = "Cancel" Cancel.Text = "Cancel" Cancel.Parent = Mainframe Cancel.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Cancel.Position = UDim2.new(0.5, 0, 1, -40) Cancel.Active = true
local Response = Proceed:Clone() Response.Name = "Response" Response.Active = true
Response.Size = UDim2.new(0, 40, 0, 40) Response.Text = "X" Response.Parent = Mainframe Response.Position = UDim2.new(0, 10, 0.5, -20)
end return MainGui end
Functions.PurchaseAuthorisation = function(Player, Product, Gui, Call, ExtraAuthentication)
if Call:lower() == "procan" and not ExtraAuthentication then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait() Services.MarketplaceService:PromptPurchase(Player, Product)
elseif Call:lower() == "procan" and type(ExtraAuthentication) == "number" then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait() Services.MarketplaceService:PromptPurchase(Player, Product)
-- Wohh! I'm using the actual MarketplaceService. Sadly, this is the case and creates extra unnecessary steps, but hey -- this is just a demonstration!
elseif Call:lower() == "procan" and ExtraAuthentication then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait()
end -- Ended this here because it will be called a second time. A purchase will take place a little further ahead.
if Call:lower() == "auth" and ExtraAuthentication then -- Rather simple, really.. Just the same thing over and over again, yet it's not. I don't know. Lol.
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait() Services.MarketplaceService:PromptPurchase(Player, Product)
end end -- Why do I not indent? This is supposed to be organised! Old habbits cannot die off so quickly, that's for sure.
Functions.ProductPurchaseAuthorisation = function(Player, Product, Gui, Call, ExtraAuthentication) -- Long name, huh? I'm not one for always shortening unless I need clones.
if Call:lower() == "procan" and not ExtraAuthentication then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait() Services.MarketplaceService:PromptProductPurchase(Player, Product)
elseif Call:lower() == "procan" and type(ExtraAuthentication) == "number" then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait() Services.MarketplaceService:PromptProductPurchase(Player, Product)
elseif Call:lower() == "procan" and ExtraAuthentication then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait()
end
if Call:lower() == "auth" and ExtraAuthentication then
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false) wait() Services.MarketplaceService:PromptProductPurchase(Player, Product)
end end
MarketplaceService.PromptPurchase = function(Player, ProductID, ExtraAuthentication, WaitDuration) -- Could this get any more simpler? Probably! On second thought, this too, makes up a lot of the script. Yikes. Stuff was supposed to be simple!
if Player.PlayerGui:FindFirstChild("Authorisation") then return end
if ExtraAuthentication == nil and WaitDuration == nil or not ExtraAuthentication and WaitDuration == false then
local Product = MarketplaceService:GetProductInfo(ProductID) -- This is really unnecessary.
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) Gui.Mainframe.ItemImage.Image = Gui.Mainframe.ItemImage.Image:gsub("$ID", ProductID)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(3) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return else
Functions.PurchaseAuthorisation(Player, ProductID, Gui, "procan", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
elseif type(ExtraAuthentication) == "number" and WaitDuration == nil then -- Disables the necessity of "ExtraAuthentication", allowing you to change WaitDuration.
if ExtraAuthentication < 3 then ExtraAuthentication = 3 end
local Product = MarketplaceService:GetProductInfo(ProductID) -- This is really unnecessary.
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) Gui.Mainframe.ItemImage.Image = Gui.Mainframe.ItemImage.Image:gsub("$ID", ProductID)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(ExtraAuthentication) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return else
Functions.PurchaseAuthorisation(Player, ProductID, Gui, "procan", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
elseif ExtraAuthentication and WaitDuration == nil then WaitDuration = 3
local Product = MarketplaceService:GetProductInfo(ProductID)
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) Gui.Mainframe.ItemImage.Image = Gui.Mainframe.ItemImage.Image:gsub("$ID", ProductID)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(WaitDuration) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return else
Functions.PurchaseAuthorisation(Player, ProductID, Gui, "procan", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
repeat wait() until Player.PlayerGui:FindFirstChild("Authorisation") == nil
Gui = Functions.CreateGui(Player, "auth")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
Gui.Mainframe.Response.MouseButton1Click:connect(function() -- Well this is some _"great"_ authorisation, eh?
if Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundButton and not Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Active = true
elseif Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundDefaultButton and Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Active = false
end
end)
Gui.Mainframe.Proceed.MouseButton1Click:connect(function() -- Hey, that's pretty good!
if not Gui.Mainframe.Proceed.Active then return 
elseif Gui.Mainframe.Proceed.Active then
Functions.PurchaseAuthorisation(Player, ProductID, Gui, "auth", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
elseif ExtraAuthentication and WaitDuration then -- A repeat of the above, just with a "WaitDuration" acception.
if WaitDuration < 3 then WaitDuration = 3 end
local Product = MarketplaceService:GetProductInfo(ProductID)
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(WaitDuration) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
repeat wait() until Player.PlayerGui:FindFirstChild("Authorisation") == nil
Gui = Functions.CreateGui(Player, "auth")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
Gui.Mainframe.Response.MouseButton1Click:connect(function()
if Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundButton and not Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Active = true
elseif Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundDefaultButton and Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Active = false
end
end)
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return 
elseif Gui.Mainframe.Proceed.Active then
Functions.PurchaseAuthorisation(Player, ProductID, Gui, "auth", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
end
end
MarketplaceService.PromptProductPurchase = function(Player, ProductID, ExtraAuthentication, WaitDuration) -- A repeat of the above, except it's for "Developer Products". Better use it right, or this will error! ;)
if Player.PlayerGui:FindFirstChild("Authorisation") then return end
if ExtraAuthentication == nil and WaitDuration == nil or not ExtraAuthentication and WaitDuration == false then
local Product = MarketplaceService:GetProductInfo(ProductID, Enum.InfoType.Product) -- Gets the product type, otherwise this call would have been more or less unnecessary.
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) Gui.Mainframe.ItemImage.Image = Gui.Mainframe.ItemImage.Image:gsub("$ID", ProductID)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(3) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return else
Functions.ProductPurchaseAuthorisation(Player, ProductID, Gui, "procan", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
elseif type(ExtraAuthentication) == "number" and WaitDuration == nil then -- Disables the necessity of "ExtraAuthentication", allowing you to change WaitDuration.
if ExtraAuthentication < 3 then ExtraAuthentication = 3 end
local Product = MarketplaceService:GetProductInfo(ProductID) -- This is really unnecessary.
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) Gui.Mainframe.ItemImage.Image = Gui.Mainframe.ItemImage.Image:gsub("$ID", ProductID)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(ExtraAuthentication) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return else
Functions.ProductPurchaseAuthorisation(Player, ProductID, Gui, "procan", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
elseif ExtraAuthentication and WaitDuration == nil then WaitDuration = 3
local Product = MarketplaceService:GetProductInfo(ProductID, Enum.InfoType.Product)
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) Gui.Mainframe.ItemImage.Image = Gui.Mainframe.ItemImage.Image:gsub("$ID", ProductID)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(WaitDuration) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return else
Functions.ProductPurchaseAuthorisation(Player, ProductID, Gui, "procan", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
repeat wait() until Player.PlayerGui:FindFirstChild("Authorisation") == nil
Gui = Functions.CreateGui(Player, "auth")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
Gui.Mainframe.Response.MouseButton1Click:connect(function()
if Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundButton and not Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Active = true
elseif Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundDefaultButton and Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Active = false
end
end)
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return 
elseif Gui.Mainframe.Proceed.Active then
Functions.ProductPurchaseAuthorisation(Player, ProductID, Gui, "auth", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
elseif ExtraAuthentication and WaitDuration then
local Product = MarketplaceService:GetProductInfo(ProductID, Enum.InfoType.Product)
local Gui = Functions.CreateGui(Player, "procan")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
wait(WaitDuration) Gui.Mainframe.Proceed.Active = true Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
repeat wait() until Player.PlayerGui:FindFirstChild("Authorisation") == nil
Gui = Functions.CreateGui(Player, "auth")
Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$ITEM", Product.Name) Gui.Mainframe.Body.Text = Gui.Mainframe.Body.Text:gsub("$PRICE", Product.PriceInRobux) Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false)
Gui.Mainframe.Cancel.MouseButton1Click:connect(function()
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position - UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end)
Gui.Mainframe.Response.MouseButton1Click:connect(function()
if Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundButton and not Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Gui.Mainframe.Proceed.Active = true
elseif Gui.Mainframe.Response.Style == Enum.ButtonStyle.RobloxRoundDefaultButton and Gui.Mainframe.Proceed.Active then
Gui.Mainframe.Response.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Style = Enum.ButtonStyle.RobloxRoundButton Gui.Mainframe.Proceed.Active = false
end
end)
Gui.Mainframe.Proceed.MouseButton1Click:connect(function()
if not Gui.Mainframe.Proceed.Active then return 
elseif Gui.Mainframe.Proceed.Active then
Functions.ProductPurchaseAuthorisation(Player, ProductID, Gui, "auth", ExtraAuthentication)
Gui.Mainframe:TweenPosition(Gui.Mainframe.Position + UDim2.new(0, 0, 1, 0), "In", "Quad", 0.5, false) wait(0.5) Gui:Destroy()
end
end)
end
end
function MarketplaceService:GetProductInfo(AssetID, ProductType) -- Recreating the other events/functions, because you know -- why not. I mean, this is a module, meaning it should contain the traditional methods, too. I suppose it's good because you don't have to get the service of the MarketplaceService, but instead would require a module. /shrug
if ProductType == nil then
return Services.MarketplaceService:GetProductInfo(AssetID)
elseif ProductType ~= nil then
return Services.MarketplaceService:GetProductInfo(AssetID, ProductType)
end
end
function MarketplaceService:PlayerOwnsAsset(Player, AssetID)
return Services.MaerketplaceService:PlayerOwnsAsset(Player, AssetID)
end
return MarketplaceService -- Why am I commenting this stuff? I never comment. It looks gross to me, but I'm _trying_ to be more _"organised"_ as some people would call it.																															-- Send noodles. Haw haw haw I'm so funny!!1 XDXdxxdXDxD
