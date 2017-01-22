--[[
Usage:
local RGBHex = require(ModuleLocation/ModuleID)
local R, G, B = RGBHex.ToRGB("#2C3E50") print(R, G, B)

local Hex = RGBHex.ToHex({44, 62, 80}) print(Hex)
-- OR
local Hex = RGBHex.ToHex({"44", "62", "80"}) print(Hex)
-- OR
local Hex = RGBHex.ToHex("44, 62, 80") print(Hex)
--]]

local Functions = {}
Functions.ToRGB = function(Hex) Hex = Hex:gsub("#", "") return tonumber("0x" .. Hex:sub(1, 2)), tonumber("0x" .. Hex:sub(3, 4)), tonumber("0x" .. Hex:sub(5, 6)) end
Functions.ToHex = function(RGB)
local Hex = "#"
if type(RGB) == "string" then for Colour in RGB:gmatch("%d+") do Hex = Hex .. ("%X"):format(tostring(Colour)) end
elseif type(RGB) == "table" then for _, Colour in pairs(RGB) do Hex = Hex .. ("%X"):format(tostring(Colour)) end end
return Hex end
return Functions
