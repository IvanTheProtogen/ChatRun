local ExtraAbilities;if game:GetService("RunService"):IsClient()then ExtraAbilities=loadstring(game:HttpGet("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()else ExtraAbilities=loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()end;

local AuthPlayers = {}

local plrs = game:GetService("Players")

local FindPlayer = function(name)
	local namee = string.lower(name)
	for i,v in pairs(plrs:GetPlayers()) do 
		if string.lower(string.sub(v.DisplayName,1,#name)) == namee then 
			return v
		elseif string.lower(string.sub(v.Name,1,#name)) == namee then 
			return v 
		elseif string.lower(tostring(v.UserId)) == namee then 
			return v 
		end
	end 
	return nil 
end 

local WhenChatted = function(msg)
	if string.sub(msg,1,4) == "/run" then
		ExtraAbilities.Chat(game:GetService("HttpService"):JSONEncode({pcall(function()return loadstring(string.sub(msg,6,#msg))()end)}));
		return true 
	end 
	return false 
end 

local WhenChattedSpecial = function(msg) 
	if WhenChatted(msg) then return end 
	if string.sub(msg,1,5) == "/auth" then 
		local plr = FindPlayer(string.sub(msg,7,#msg))
		if plr == nil then 
			ExtraAbilities.Chat("~~ Player not found!")
			return 
		end 
		if typeof(AuthPlayers[tostring(plr.UserId)]) ~= "RBXScriptConnection" then 
			AuthPlayers[tostring(plr.UserId)] = plr.Chatted:Connect(WhenChatted)
			ExtraAbilities.Chat("~~ Player has been authorized to use /run !")
		else 
			AuthPlayers[tostring(plr.UserId)]:Disconnect()
			AuthPlayers[tostring(plr.UserId)] = nil 
			ExtraAbilities.Chat("~~ Player is no longer authorized!")
		end 
	end 
end 

plrs.LocalPlayer.Chatted:Connect(WhenChattedSpecial)

ExtraAbilities.Chat("~~ ChatRun active")
