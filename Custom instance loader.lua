local InstanceHandler = {Instances = {}} -- I'll be adding an instance search at some point.
local instance = {}
function InstanceHandler.new(Ins, Par)
	local self = {Part = Instance.new(Ins)}
	setmetatable(self, {__index=instance})
	if typeof(Par) == "Instance" then
		self.Part.Parent = Par
	elseif typeof(Par) == "string" then
		local Location = game:FindFirstChild(Par, true)
		self.Part.Parent = Location;
	end
	return self
end;

function instance:SetProperties(...)
	for property, value in pairs(...) do
		self.Part[property] = value
	end
end

-- example
local newpart = InstanceHandler.new("Part", "Workspace")
newpart:SetProperties({Transparency = 0.5})
