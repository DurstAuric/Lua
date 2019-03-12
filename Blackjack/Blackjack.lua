local Cards, Dealer, Player, Played, Pot, Game = {
"2C-3C-4C-5C-6C-7C-8C-9C-10C-JC-QC-KC-AC",
"2D-3D-4D-5D-6D-7D-8D-9D-10D-JD-QD-KD-AD",
"2H-3H-4H-5H-6H-7H-8H-9H-10H-JH-QH-KH-AH",
"2S-3S-4S-5S-6S-7S-8S-9S-10S-JS-QS-KS-AS"}, {Deck = {}, Total = "0"}, {Deck = {}, Balance = 50000, Total = "0"}, {}, 0, {} Game.MainGame = script.Parent.MainGame

for Pos, Deck in pairs(Cards) do local Suit = {} Deck:gsub("%w+", function(Match) table.insert(Suit, Match) end) Cards[Pos] = Suit end
Game.MainGame.Stats.Money.Text = "Money: $" .. tostring(Player.Balance):reverse():gsub("%d%d%d", "%1,"):gsub(",$", ""):reverse()

function CheckCard(Card) 
	local Value = ""
	if Card:match("%d+") == "2" then Value = "2" end
	if Card:match("%d+") == "3" then Value = "3" end
	if Card:match("%d+") == "4" then Value = "4" end
	if Card:match("%d+") == "5" then Value = "5" end
	if Card:match("%d+") == "6" then Value = "6" end
	if Card:match("%d+") == "7" then Value = "7" end
	if Card:match("%d+") == "8" then Value = "8" end
	if Card:match("%d+") == "9" then Value = "9" end
	if Card:match("%d+") == "10" then Value = "10" end
	if Card:match("%a") == "J" then Value = "10" end
	if Card:match("%a") == "Q" then Value = "10" end
	if Card:match("%a") == "K" then Value = "10" end
	if Card:match("%a") == "A" then Value = "1/11" end
	return Value
end

function Player:UpdateBalance() Game.MainGame.Stats.Money.Text = "Money: $" .. tostring(self.Balance):reverse():gsub("%d%d%d", "%1,"):gsub(",$", ""):reverse() end

function Player:AddTotal(Deck)
	if #Deck > 2 then
		Player.Total = "0"
	end
	for _, Card in pairs(Deck) do
		if not Player.Total:match("%d+/%d+") then
			if CheckCard(Card) ~= "1/11" then
				Player.Total = tostring(tonumber(Player.Total) + tonumber(CheckCard(Card)))
			elseif CheckCard(Card) == "1/11" then
				Player.Total = tostring(tonumber(Player.Total) + 1 .. "/" .. tonumber(Player.Total) + 11)
			end
		elseif Player.Total:match("%d+/%d+") then
			if tonumber(Player.Total:match("/(%d+)")) > 21 then
				if CheckCard(Card) ~= "1/11" then
					Player.Total = tostring(tonumber(Player.Total:match("(%d+)/")) + tonumber(CheckCard(Card)))
				elseif CheckCard(Card) == "1/11" then
					Player.Total = tostring(tonumber(Player.Total:match("(%d+)/")) + 1)
				end
			elseif tonumber(Player.Total:match("/(%d+)")) < 21 then
				if CheckCard(Card) ~= "1/11" then
					Player.Total = tostring(tonumber(Player.Total:match("(%d+)/")) + tonumber(CheckCard(Card)) .. "/" .. tonumber(Player.Total:match("/(%d+)")) + tonumber(CheckCard(Card)))
				elseif CheckCard(Card) == "1/11" then
					Player.Total = tostring(tonumber(Player.Total:match("(%d+)/")) + 1 .. "/" .. tonumber(Player.Total:match("/(%d+)")) + 11)
				end
			end
		end
	end
end

function Player:DrawCard()
	math.randomseed(tick() % math.random(tick()))
	local Card = math.random(#Cards) Card = Cards[Card][math.random(#Cards[Card])]
	for Drawn = 1, #Played do
		if Played[Drawn] == Card then
			repeat 
				Card = math.random(#Cards) Card = Cards[Card][math.random(#Cards[Card])]				
			until Played[Drawn] ~= Card break
		end
	end
	table.insert(Played, Card)
	return Card
end

function Player:Deal()
	local C1, C2 = Player:DrawCard(), Player:DrawCard()
	Player.Deck[#Player.Deck + 1] = C1 Player.Deck[#Player.Deck + 1] = C2 
	Player:AddTotal(Player.Deck)
end

function Player:Hit()
	local C = Player:DrawCard() Player.Deck[#Player.Deck + 1] = C print(C)
	Player:AddTotal(Player.Deck)
	wait(1)
	Game.MainGame.PlayerHand.Text = Game.MainGame.PlayerHand.Text .. ", " .. C
	Game.MainGame.Stats.CardTotal.Text = "Card total: " .. Player.Total
	print(Player.Total)
	if tonumber(Player.Total:match("(%d+)%p?")) > 21 then
		Game.MainGame.PlayerHand.Text = "Player bust!" wait(1)
		Game:End()
	end
end

function Player:Stand()
	if tonumber(Dealer.Total) <= 16 then
		repeat Dealer:Hit() until tonumber(Dealer.Total) >= 17
		Game:End()
	else
		Game:End()
	end
end

function Player:Win(Amount) Player.Balance = Player.Balance + Amount Player:UpdateBalance() end

function Dealer:AddTotal(Deck)
	local Ace = false
	if #Deck > 2 then
		Dealer.Total = "0"
	end
	for _, Card in pairs(Deck) do
		if CheckCard(Card) ~= "1/11" then
			Dealer.Total = tostring(tonumber(Dealer.Total) + CheckCard(Card))
		elseif CheckCard(Card) == "1/11" then
			if not Ace then
				Dealer.Total = tostring(tonumber(Dealer.Total) + 11) Ace = true
			else
				Dealer.Total = tostring(tonumber(Dealer.Total) + 1)
			end
		end
	end
end

function Dealer:DrawCard()
	math.randomseed(tick() % math.random(tick()))
	local Card = math.random(#Cards) Card = Cards[Card][math.random(#Cards[Card])]
	for Drawn = 1, #Played do
		if Played[Drawn] == Card then
			repeat 
				Card = math.random(#Cards) Card = Cards[Card][math.random(#Cards[Card])]
			until Played[Drawn] ~= Card break
		end
	end
	table.insert(Played, Card) 
	return Card
end

function Dealer:Deal()
	local C1, C2 = Dealer:DrawCard(), Dealer:DrawCard()
	Dealer.Deck[#Dealer.Deck + 1] = C1 Dealer.Deck[#Dealer.Deck + 1] = C2
	Dealer:AddTotal(Dealer.Deck)
end

function Dealer:Hit()
	local C = Dealer:DrawCard() Dealer.Deck[#Dealer.Deck + 1] = C
	Dealer:AddTotal(Dealer.Deck)
	wait(1)
	if #Dealer.Deck == 3 then
		Game.MainGame.DealerHand.Text = string.gsub(Game.MainGame.DealerHand.Text, "\?+", Dealer.Deck[2])
	end
	Game.MainGame.DealerHand.Text = Game.MainGame.DealerHand.Text .. ", " .. C
	if tonumber(Dealer.Total) > 21 then 
		Game:End()
	end
end

function Game:Start()
	Dealer.Deck = {} Dealer.Total = "0" Player.Deck = {} Player.Total = "0" Played = {} Pot = 0
	Dealer:Deal() Player:Deal() Game.MainGame.Stats.CardTotal.Text = "Card total: " .. Player.Total
	Pot = Game.MainGame.Better.InputBox.Text Player.Balance = Player.Balance - Pot
	Game.MainGame.Deal.CurrentBet.Text = "Pot: " .. Game.MainGame.Better.CurrentBet.Text:match("[%d+,?%d?]+")
	Player:UpdateBalance()
	Game.MainGame.Actions:TweenPosition(UDim2.new(0.258, 0 ,0.813, 0), "In", "Quad", 0.5, true)
	for Pos, Card in pairs(Player.Deck) do
		Game.MainGame.PlayerHand.Text = Game.MainGame.PlayerHand.Text .. Card .. ", "
		if Pos == #Player.Deck then
			Game.MainGame.PlayerHand.Text = Game.MainGame.PlayerHand.Text:sub(1, #Game.MainGame.PlayerHand.Text - 2)
		end
	end
	Game.MainGame.DealerHand.Text = Dealer.Deck[1] .. ", ??"
	Game.MainGame.Actions.Hit.Active = true Game.MainGame.Actions.Stand.Active = true Game.MainGame.Actions.DDown.Active = true
	print(Dealer.Deck[1], Dealer.Deck[2], Dealer.Total)
	if Game:CheckNatural() == "Push" or Game:CheckNatural() == "Win" or Game:CheckNatural() == "Loss" then
		Game:End()
	end
end

function Game:End()
	--if Player.Total ~= "0" and Dealer.Total ~= "0" then
	if not tonumber(Player.Total:match("/(%d+)")) then
		if tonumber(Player.Total) <= 21 or tonumber(Dealer.Total) <= 21 then
			if Game:CheckNatural() == "Win" then
				Game.MainGame.PlayerHand.Text = "Player blackjack and wins " .. Pot * 1.5 .. "!"
				Player:Win(Pot * 1.5) 
				print("Win: ", Pot * 1.5)
				wait(1)
			elseif Game:CheckNatural() == "Push" then
				Game.MainGame.PlayerHand.Text = "Player pushes and wins " .. Pot .. "!"
				Player:Win(Pot)
				wait(1)
			elseif Game:CheckNatural() == "Loss" then
				Game.MainGame.DealerHand.Text = "Dealer blackjack!"
				wait(1)
			elseif tonumber(Player.Total) == tonumber(Dealer.Total) and tonumber(Dealer.Total) <= 21 then
				Game.MainGame.PlayerHand.Text = "Player pushes and wins " .. Pot .. "!"
				Player:Win(Pot)
				wait(1)
			elseif tonumber(Player.Total) <= 21 and tonumber(Player.Total) > tonumber(Dealer.Total) and tonumber(Dealer.Total) < 21 then
				Game.MainGame.PlayerHand.Text = "Player wins " .. Pot * 2 .. "!"
				Player:Win(Pot * 2) 
				print("Win: ", Pot * 2)
				wait(1)
			elseif tonumber(Player.Total) < 21 and tonumber(Player.Total) < tonumber(Dealer.Total) then
				Game.MainGame.PlayerHand.Text = "Player loses!"
				print("Loss")
				wait(1)
			elseif tonumber(Player.Total) == 21 and tonumber(Dealer.Total) < tonumber(Player.Total) then
				Game.MainGame.PlayerHand.Text = "Player wins " .. Pot * 2 .. "!"
				Player:Win(Pot * 2) 
				print("Win: ", Pot * 2)
				wait(1)
			elseif tonumber(Player.Total) < tonumber(Dealer.Total) and tonumber(Dealer.Total) == 21 then
				Game.MainGame.DealerHand.Text = "Dealer blackjack!"
				print("Loss")
				wait(1)
			end
		elseif tonumber(Player.Total) > 21 then
			print("Bust")
		elseif tonumber(Dealer.Total) > 21 then
			Game.MainGame.DealerHand.Text = "Dealer bust!"
			print(Dealer.Total, Player.Total)
			Player:Win(Pot * 2)
			wait(1)
		end
	elseif tonumber(Player.Total:match("/(%d+)")) and tonumber(Player.Total:match("/(%d+)")) <= 21 or tonumber(Dealer.Total) <= 21 then
		if tonumber(Player.Total:match("/(%d+)")) <= 21 and tonumber(Player.Total:match("/(%d+)")) > tonumber(Dealer.Total) and tonumber(Dealer.Total) <= 21 then
			Game.MainGame.PlayerHand.Text = "Player wins " .. Pot * 2 .. "!"
			Player:Win(Pot * 2) 
			print("Win: ", Pot * 2)
			wait(1)
		elseif tonumber(Player.Total:match("/(%d+)")) < 21 and tonumber(Player.Total:match("/(%d+)")) < tonumber(Dealer.Total) and tonumber(Dealer.Total) <= 21 then
			Game.MainGame.PlayerHand.Text = "Player loses!"
			print("Loss")
			wait(1)
		elseif tonumber(Dealer.Total) > 21 then
			Game.MainGame.DealerHand.Text = "Dealer bust!"
			print(Dealer.Total, Player.Total)
			Player:Win(Pot * 2)
			wait(1)
		end
	end
	print(Dealer.Total)
	Game:Restore()
end

function Game:CheckNatural()
	if (CheckCard(Player.Deck[1]) == "1/11" and CheckCard(Player.Deck[2]) == "10") or (CheckCard(Player.Deck[1]) == "10" and CheckCard(Player.Deck[2]) == "1/11") then
		if (CheckCard(Dealer.Deck[1]) == "1/11" and CheckCard(Dealer.Deck[2]) == "10") or (CheckCard(Dealer.Deck[1]) == "10" and CheckCard(Dealer.Deck[2]) == "1/11") then
			return "Push"
		elseif tonumber(Dealer.Total) < 21 then
			return "Win"
		end
	elseif (CheckCard(Dealer.Deck[1]) == "1/11" and CheckCard(Dealer.Deck[2]) == "10") or (CheckCard(Dealer.Deck[1]) == "10" and CheckCard(Dealer.Deck[2]) == "1/11") then
		if tonumber(Player.Total) < 21 or tonumber(Player.Total:match("/(%d+)")) < 21 then
			return "Loss"
		end
	end
end

function Game:Restore()
	Game.MainGame.Stats.CardTotal.Text = "Card total: 0"
	Game.MainGame.Deal.CurrentBet.Text = "Pot: 0"
	Game.MainGame.Deal:TweenPosition(Game.MainGame.Deal.Position - UDim2.new(0, 0, 0, 75), "Out", "Quad", 0.5, true)
	Game.MainGame.Better:TweenPosition(Game.MainGame.Better.Position - UDim2.new(0, 0, 0, 95), "Out", "Quad", 0.5, true)
	Game.MainGame.Actions:TweenPosition(UDim2.new(0.258, 0 , 1, 0), "Out", "Quad", 0.5, true)
	Game.MainGame.Actions.Hit.Active = false Game.MainGame.Actions.Stand.Active = false Game.MainGame.Actions.DDown.Active = false
	Game.MainGame.Better.ApplyBet.Active = true 
	Game.MainGame.Better.ApplyBet.Style = Enum.ButtonStyle.RobloxRoundDefaultButton Game.MainGame.PlayerHand.Text, Game.MainGame.DealerHand.Text = "", ""
end

Game.MainGame.Deal.MouseButton1Click:connect(function()
	if Game.MainGame.Deal.Active then
		Game:Start() Game.MainGame.Deal.Active = false Game.MainGame.Deal.Style = Enum.ButtonStyle.RobloxRoundButton
		Game.MainGame.Deal:TweenPosition(Game.MainGame.Deal.Position + UDim2.new(0, 0, 0, 75), "Out", "Quad", 0.5, true)
	end
end)

Game.MainGame.Actions.Hit.MouseButton1Click:connect(function() 
	if Game.MainGame.Actions.Hit.Active then 
		Player:Hit() 
	end 
end)

Game.MainGame.Actions.Stand.MouseButton1Click:connect(function()
	if Game.MainGame.Actions.Stand.Active then
		Player:Stand()
	end
end)
