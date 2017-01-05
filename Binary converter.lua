function ToBinary(Message)
local Converted = ""
local function ConvertCharacter(Integer, BaseInteger)
local Base, Keys, Out, Decimal = BaseInteger or 10, "01", ""
for Loop = 1, 8 do
Integer, Decimal = math.floor(Integer / Base), math.fmod(Integer, Base) + 1
Out = string.sub(Keys, Decimal, Decimal) .. Out
end
return Out
end
for Convert in Message:gmatch("[%w%s%p%d]") do
Converted = Converted .. (ConvertCharacter(string.byte(Convert), 2)) .. " "
end
Converted = Converted:sub(0, #Converted - 1)
return Converted
end
function BinaryToChar(Message)
local Converted = ""
for Convert in Message:gmatch("[%d]+") do
Converted = Converted .. string.char(tonumber(Convert, 2))
end
return Converted
end
