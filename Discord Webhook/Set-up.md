#Set-up / installation
-----
In order to set this up, you must place these scripts in specific locations, and must be certain scripts or it will not work as expected.

#Main script
-----
Open up the "Feedback Module.lua" script, copy the code and then open up ROBLOX Studio and go to the specific place you would like to insert this into. Create a "Script" -- name it "Feedback Module" -- and place it into the ServerScriptService. Open it up and paste the code into it.

Open up the "Settings.lua" script, copy the code and then return to the ROBLOX Studio tab and create a "ModuleScript" inside the script you have just created. Name it "Settings" and then paste the code you have just copied into the module script.

Alternatively, you may grab yourself a copy of it here: https://www.roblox.com/library/569608735/Discord-Feedback-Webhook

-----

You're more or less done now, because it's using require to grab the instance of a "MainModule", also known as a "Private module".
