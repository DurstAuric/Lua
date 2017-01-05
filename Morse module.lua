-- ModuleScript which converts text/userinput into "Morse Code".

																															--[[
											-=[ Scripted by DurstAuric ]=-
											------------------------------
							Take a copy here: https://www.roblox.com/item.aspx?id=587154010
							---------------------------------------------------------------
	To use this module, you may either require it by ID: 587154010 -- or by inserting this module into your game and
	requiring it by the object itself.
	
	----------------------------
	The following functions are:
	
	* ToMorse(Input)
		- Input's type is a string.
		
	* FromMorse(Input)
		- Input's type is a string.
	
	------	
	Usage:
	local MorseModule = require(587154010)
	local Morse = MorseModule.ToMorse("Hello there. This is a test.")
	local Text = MorseModule.FromMorse("... -.-. .-. .. .--. - . -.. / -... -.-- / -.. ..- .-. ... - .- ..- .-. . -.-. .-.-.-")
	
	Thank you for using this module.
																										 ~DurstAuric
																															--]]
local Functions = {}
local Morse = {
-- Letters
["A"] = ".-",
["B"] = "-...",
["C"] = "-.-.",
["D"] = "-..",
["E"] = ".",
["F"] = "..-.",
["G"] = "--.",
["H"] = "....",
["I"] = "..",
["J"] = ".---",
["K"] = "-.-",
["L"] = ".-..",
["M"] = "--",
["N"] = "-.",
["O"] = "---",
["P"] = ".--.",
["Q"] = "--.-",
["R"] = ".-.",
["S"] = "...",
["T"] = "-",
["U"] = "..-",
["V"] = "...-",
["W"] = ".--",
["X"] = "-..-",
["Y"] = "-.--",
["Z"] = "--..",
-- Numbers
["0"] = "-----",
["1"] = ".----",
["2"] = "..---",
["3"] = "...--",
["4"] = "....-",
["5"] = ".....",
["6"] = "-....",
["7"] = "--...",
["8"] = "---..",
["9"] = "----.",
-- Special characters
["."] = ".-.-.-",
[","] = "--..--",
[":"] = "---...",
["-"] = "-....-",
["'"] = ".----.",
['"'] = ".-..-.",
["/"] = "-..-.",
["?"] = "..--..",
["@"] = ".--.-.",
["="] = "-...-",
-- Other special
["("] = "-.--.-",
[")"] = "-.--.-",
[" "] = "/",
}
local Chars = {
-- Letters
[".-"] = "A",
["-..."] = "B",
["-.-."] = "C",
["-.."] = "D",
["."] = "E",
["..-."] = "F",
["--."] = "G",
["...."] = "H",
[".."] = "I",
[".---"] = "J",
["-.-"] = "K",
[".-.."] = "L",
["--"] = "M",
["-."] = "N",
["---"] = "O",
[".--."] = "P",
["--.-"] = "Q",
[".-."] = "R",
["..."] = "S",
["-"] = "T",
["..-"] = "U",
["...-"] = "V",
[".--"] = "W",
["-..-"] = "X",
["-.--"] = "Y",
["--.."] = "Z",
-- Numbers
["-----"] = "0",
[".----"] = "1",
["..---"] = "2",
["...--"] = "3",
["....-"] = "4",
["....."] = "5",
["-...."] = "6",
["--..."] = "7",
["---.."] = "8",
["----."] = "9",
-- Special characters
[".-.-.-"] = ".",
["--..--"] = ",",
["---..."] = ":",
["-....-"] = "-",
[".----."] = "'",
[".-..-."] = '"',
["-..-."] = "/",
["..--.."] = "?",
[".--.-."] = "@",
["-...-"] = "=",
-- Other special
["-.--.-"] = "(",
--["-.--.-"] = ")", not needed as they're exactly the same.
["/"] = " ",
}
-- Like forreal, this is simple. Nothing more than matching.
Functions.ToMorse = function(Message)
local Out = ""
for Convert in Message:gmatch("[%w%s%d%p]") do
Convert = Morse[Convert:upper()]
if Convert == nil then
Out = Out .. "(?)" .. " "
else Out = Out .. Convert .. " "
end
end
return Out:sub(0, #Out - 1)
end
-- More matching, but with more checks.
Functions.FromMorse = function(Message)
local Out = "" local BracketFound = false
for Convert in Message:gmatch("%S+") do
if Chars[Convert] == "/" then -- Accounts for the spaces per sequence.
Out = Out .. " "
elseif Convert == "-.--.-" then -- Bracket matching. Trying to accurately convert, rather than being like (hi(
if not BracketFound then
Out = Out .. "("
BracketFound = true
elseif BracketFound then
Out = Out .. ")"
BracketFound = false
end
else
Out = Out .. Chars[Convert]
end
end
return Out
end
return Functions
