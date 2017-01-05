local Children = script:GetChildren() script = Instance.new("ModuleScript") for _, Child in pairs(Children) do Child.Parent = script end
local Services = {ServerScriptService = game:GetService("ServerScriptService"), HttpService = game:GetService("HttpService"), Players = game:GetService("Players"), ReplicatedStorage = game:GetService("ReplicatedStorage"),}
local Functions = {} local Objects = {} local Senders = {} Functions.NewInstance = function(Type, Parent, Name) local Ins = Instance.new(Type, Parent) Ins.Name = Name return Ins end
Objects.Settings = require(Services.ServerScriptService:FindFirstChild("Feedback Webhook").Settings) Objects.Client = script.Client Objects.Event = Functions.NewInstance("RemoteEvent", Services.ReplicatedStorage, "\a\n\a\ne")
Functions.CheckSenders = function(Player) for _, Plr in pairs(Senders) do if Plr:lower() == Player.Name:lower() then return true end end end
Functions.Submit = function(Button, Text, Player, TextLabel, Bool, Bool2)
if Button.Active and not Functions.CheckSenders(Player) then
local GetAvatar = Services.HttpService:GetAsync("http://rprxy.xyz/headshot-thumbnail/json?userId=" .. Player.UserId .. "&width=180&height=180") local MainUrl = Services.HttpService:JSONDecode(GetAvatar)
local ToSend = "" if Functions.CheckRating(Bool, Bool2) == true then ToSend = "http://i.imgur.com/OY0PJ7x.png" elseif Functions.CheckRating(Bool, Bool2) == false then ToSend = "http://i.imgur.com/4llrnhe.png" elseif Functions.CheckRating(Bool, Bool2) == "nothing" then ToSend = "" end
local ToJSON = {} ToJSON["content"] = Text .. "\n" .. ToSend ToJSON["username"] = tostring(Player.Name) .. " - " .. tostring(Player.UserId) ToJSON["avatar_url"] = tostring(MainUrl.Url)
local Encoded = Services.HttpService:JSONEncode(ToJSON) Services.HttpService:PostAsync(Objects.Settings.Link, Encoded) Button.Style = Enum.ButtonStyle.RobloxRoundButton TextLabel.Text = "Thank you for your feedback! You may now close this as you will be unable to send anymore feedback until you join a new server."
table.insert(Senders, Player.Name)
elseif Functions.CheckSenders(Player) then
TextLabel.Text = "You have already sent feedback in this server." return
end end
Functions.Cancel = function(MainFrame, SF) MainFrame:TweenPosition(MainFrame.Position + UDim2.new(1, 0, 0, 0), "Out", "Quad", 1, false) SF:TweenPosition(SF.Position - UDim2.new(1, 0, 0, 0), "Out", "Quad", 1, false) end
Functions.Open = function(MainFrame, SF) SF:TweenPosition(SF.Position + UDim2.new(1, 0, 0, 0), "Out", "Quad", 1, false) MainFrame:TweenPosition(MainFrame.Position - UDim2.new(1, 0, 0, 0), "Out", "Quad", 1, false) end
Functions.TChanged = function(InputBox, Characters, Text) local CLimit = Objects.Settings.CharacterLimit local TLength = #Text Characters.Text = CLimit - TLength end
Functions.CChanged = function(InputBox, Characters, Submit, Property) if tonumber(Characters.Text) <= 0 then InputBox:ReleaseFocus(false) elseif Property == "Text" and tonumber(Characters.Text) == 230 then Submit.Active = true Submit.Style = Enum.ButtonStyle.RobloxRoundDefaultButton end end
Functions.Like = function(Like, Dislike, Bool, Bool2, Image, Image2, Image3) if not Bool and not Bool2 then Like.Like.Value = not Bool Like.Image = Image3 Dislike.Image = Image2 elseif Bool and not Bool2 then Like.Like.Value = not Bool Like.Image = Image Dislike.Image = Image2 elseif not Bool and Bool2 then Like.Like.Value = not Bool Dislike.Dislike.Value = not Bool2 Like.Image = Image3 Dislike.Image = Image2 end end
Functions.Dislike = function(Like, Dislike, Bool, Bool2, Image, Image2, Image3) if not Bool and not Bool2 then Dislike.Dislike.Value = not Bool2 Like.Image = Image Dislike.Image = Image3 elseif not Bool and Bool2 then Dislike.Dislike.Value = not Bool2 Dislike.Image = Image2 elseif Bool and not Bool2 then Like.Like.Value = not Bool Dislike.Dislike.Value = not Bool2 Like.Image = Image Dislike.Image = Image3 end end
Functions.CheckRating = function(Bool, Bool2) if Bool and not Bool2 then return true elseif not Bool and Bool2 then return false elseif not Bool and not Bool2 then return "nothing" end end
Functions.CreateGui = function(Player)
local MainGui = Functions.NewInstance("ScreenGui", Player.PlayerGui, "Feedback")
local MainFrame = Functions.NewInstance("Frame", MainGui, "Mainframe") MainFrame.Size = UDim2.new(0, 330, 0, 200) MainFrame.Position = UDim2.new(2, -350, 1, -220) MainFrame.Style = Enum.FrameStyle.RobloxRound
local InputBox = Functions.NewInstance("TextBox", MainFrame, "InputBox") InputBox.Size = UDim2.new(1, -20, 0, 80) InputBox.Position = UDim2.new(0, 10, 0.5, -40) InputBox.BorderSizePixel = 0 InputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
local Corner = Functions.NewInstance("ImageLabel", InputBox, "Corner") Corner.Size = UDim2.new(0, 10, 0, 10) Corner.BackgroundTransparency = 1 Corner.Image = "rbxassetid://448221961" Corner.Position = UDim2.new(0, -10, 0, -10) InputBox.Text = "Enter your feedback." InputBox.TextXAlignment = Enum.TextXAlignment.Left InputBox.TextYAlignment = Enum.TextYAlignment.Top InputBox.TextWrapped = true
local C2, C3, C4 = Corner:Clone(), Corner:Clone(), Corner:Clone() C2.Parent, C3.Parent, C4.Parent = InputBox, InputBox, InputBox C2.Rotation, C3.Rotation, C4.Rotation = 90, 180, 270 C2.Position, C3.Position, C4.Position = UDim2.new(1, 0, 0, -10), UDim2.new(1, 0, 1, 0), UDim2.new(0, -10, 1, 0)
local Edge = Functions.NewInstance("Frame", InputBox, "Edge") Edge.BorderSizePixel = 0 Edge.Size = UDim2.new(0, 10, 1, 0) Edge.Position = UDim2.new(0, -10, 0, 0) Edge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
local E2, E3, E4 = Edge:Clone(), Edge:Clone(), Edge:Clone() E2.Parent, E3.Parent, E4.Parent = InputBox, InputBox, InputBox E2.Position = UDim2.new(1, 0, 0, 0) E3.Size, E4.Size = UDim2.new(1, 0, 0, 10), UDim2.new(1, 0, 0, 10) E3.Position, E4.Position = UDim2.new(0, 0, 0, -10), UDim2.new(0, 0, 1, 0)
local Title = Functions.NewInstance("TextLabel", MainFrame, "Title") Title.Text = "Send your feedback" Title.Size = UDim2.new(1, 0, 0, 30) Title.BackgroundTransparency = 1 Title.BorderSizePixel = 0 Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.FontSize = Enum.FontSize.Size24 Title.Font = Enum.Font.Bodoni Title.TextWrapped = true
local Characters = Title:Clone() Characters.Name = "Characters" Characters.Text = Objects.Settings.CharacterLimit Characters.Size = UDim2.new(0, 50, 0, 30) Characters.Position = UDim2.new(0, 0, 1, -32.5) Characters.Parent = MainFrame Characters.FontSize = Enum.FontSize.Size14
local Submit = Functions.NewInstance("TextButton", MainFrame, "Submit") Submit.Text = "Send" Submit.Size = UDim2.new(0, 100, 0, 30) Submit.Position = UDim2.new(0.5, -100, 1, -32.5) Submit.FontSize = Enum.FontSize.Size18 Submit.Font = Enum.Font.Bodoni Submit.TextColor3 = Color3.fromRGB(255, 255, 255) Submit.Style = Enum.ButtonStyle.RobloxRoundButton Submit.AutoButtonColor = false Submit.Active = false
local Cancel = Submit:Clone() Cancel.Parent = MainFrame Cancel.Name = "Cancel" Cancel.Text = "Close" Cancel.Position = UDim2.new(0.5, 0, 1, -32.5) Cancel.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
local ThumbUp = Functions.NewInstance("ImageButton", MainFrame, "ThumbUp") ThumbUp.Size = UDim2.new(0, 30, 0, 30) ThumbUp.Position = UDim2.new(0, 10, 0, 0) ThumbUp.Image = "rbxassetid://571463067" ThumbUp.BackgroundTransparency = 1
local ThumbDown = ThumbUp:Clone() ThumbDown.Name = "ThumbDown" ThumbDown.Parent = MainFrame ThumbDown.Position = UDim2.new(1, -40, 0, 0) ThumbDown.Image = "rbxassetid://571465244"
local Like, Dislike = Functions.NewInstance("BoolValue", ThumbUp, "Like"), Functions.NewInstance("BoolValue", ThumbDown, "Dislike")
local SF = Cancel:Clone() SF.Parent = MainGui SF.Name = "Open" SF.Text = "Send Feedback" SF.Size = UDim2.new(0, 130, 0, 30) SF.Position = UDim2.new(1, -135, 1, -50)
end Functions.OnEntrance = function(Player, Character) Functions.CreateGui(Services.Players:GetPlayerFromCharacter(Character)) wait() local Client = Objects.Client:Clone() Client.Parent = Player.PlayerGui Client.Disabled = not Client.Disabled end
Services.Players.PlayerAdded:connect(function(Player)
Player.CharacterAdded:connect(function(Character)
Functions.OnEntrance(Player, Character)
end) end)
Objects.Event.OnServerEvent:connect(function(plr, Call, Arguments)
if Call:lower() == "submit" then Functions.Submit(Arguments[1], Arguments[2], Arguments[3], Arguments[4], Arguments[5], Arguments[6])
elseif Call:lower() == "close" then Functions.Cancel(Arguments[1], Arguments[2])
elseif Call:lower() == "open" then Functions.Open(Arguments[1], Arguments[2])
elseif Call:lower() == "tchanged" then Functions.TChanged(Arguments[1], Arguments[2], Arguments[3])
elseif Call:lower() == "cchanged" then Functions.CChanged(Arguments[1], Arguments[2], Arguments[3], Arguments[4])
elseif Call:lower() == "like" then Functions.Like(Arguments[1], Arguments[2], Arguments[3], Arguments[4], Arguments[5], Arguments[6], Arguments[7])
elseif Call:lower() == "dislike" then Functions.Dislike(Arguments[1], Arguments[2], Arguments[3], Arguments[4], Arguments[5], Arguments[6], Arguments[7])
end end)
return ""
