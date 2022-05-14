if game.PlaceId == 6403373529 then
    if (not game:IsLoaded()) then
        game.Loaded:Wait();
    end;
    function teleport()
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
            if v.playing ~= v.maxPlayers then
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
            end
        end
    end
    if ServerHop then
        while wait(30) do
            local descendants = Workspace.Map:GetDescendants()
            for index, descendant in pairs(descendants) do
                if descendant.Name == "Collision" then
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(descendant.Position)
                    wait(2)
                    game:GetService("ReplicatedStorage").Events.Update:FireServer()
                end
            end
            syn.queue_on_teleport([[
                getgenv().ServerHop = true 
                loadstring(game:HttpGet(""))()
            ]])
            repeat wait()
                teleport()
            until not ServerHop
        end
    end
end
