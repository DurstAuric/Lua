local PlayerHandler = require(game:GetService("ServerStorage"):FindFirstChild("PlayerHandler", true));

local CollectionService = game:GetService("CollectionService");
local Teams = {Lobby = {}};

function Teams.AddTeam(Team)
	if not Teams[Team] then
		Teams[Team] = {};
	end
end

function Teams:CheckForMember(Search)
	for TeamName, Team in pairs(Teams) do
		if typeof(Team) == "table" then
			for _, Player in pairs(Team) do
				if Player == Search.Name then
					return TeamName;
				end
			end
		end
	end
	
	return false;
end

function Teams:GetAllTeamMembers(Team)
	local Players = {};
	
	for _, Player in pairs(Teams[Team]) do table.insert(Players, Player); end
	
	return Players;
end


function Teams:CheckForTeamMember(Team, Search)
	for _, Player in pairs(Teams[Team]) do
		if Player == Search.Name then
			return true;
		end
	end
	
	return false;
end

function Teams:AddMember(Team, Search)
	local CurrentTeam = Teams:CheckForMember(Search)
	
	if CurrentTeam then
		for Pos, Player in pairs(Teams[CurrentTeam]) do
			if Player == Search.Name then
				table.remove(Teams[CurrentTeam], Pos);
				CollectionService:RemoveTag(Search, CurrentTeam);
			end
		end
	end
	
	table.insert(Teams[Team], Search.Name);
	CollectionService:AddTag(Search, Team);
	PlayerHandler.Players[Search]:UpdateTeam(Team);
end

function Teams:RemoveMember(Search, Team)
	if not Team then Team = Teams:CheckForMember(Search); end
	
	for Pos, Player in pairs(Teams[Team]) do
		if Player == Search.Name then
			table.remove(Teams[Team], Pos);
		end
	end
end


return Teams;
