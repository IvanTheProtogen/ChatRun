local ExtraAbilities;if game:GetService("RunService"):IsClient()then ExtraAbilities=loadstring(game:HttpGet("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()else ExtraAbilities=loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()end;

local function onChatted(tp,plr,msg)
	if plr == game:GetService("Players").LocalPlayer then 
		if string.sub(msg,1,2) == "$ " then 
			ExtraAbilities.Chat("~~ RESULT: "..game:GetService("HttpService"):JSONEncode({pcall(function()return loadstring(string.sub(msg,3,#msg))()end)}))
		end
	end
end

game:GetService("Players").PlayerChatted:Connect(onChatted)
