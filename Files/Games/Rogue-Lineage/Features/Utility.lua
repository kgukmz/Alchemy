local Utility = {}

local ReplicatedStorage = GetService("ReplicatedStorage")
local HttpService = GetService("HttpService")
local Players = GetService("Players")

function Utility:CharacterReset()
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    
    if (Character == nil) then
        return
    end

    local Head = Character:FindFirstChild("Head")

    if (Head == nil) then
        return
    end

    Head:Destroy()
end

function Utility:ServerHop()
    local ServerInfo = ReplicatedStorage.ServerInfo
    local Servers = ServerInfo:GetChildren()

    local RandomIndex = math.random(1, #Servers)
    local ChosenServer = Servers[RandomIndex]

    if (ChosenServer ~= nil) then
        local Job_Id = ChosenServer.Name
        ReplicatedStorage.Requests.JoinPublicServer:FireServer(Job_Id)
    end
end

function Utility:HopToSmallest()
    local ServerInfo = ReplicatedStorage.ServerInfo
    local Servers = {}

    for i, Server in next, ServerInfo:GetChildren() do
        local Players = Server:FindFirstChild("Players")
        local PlayersDecoded = HttpService:JSONDecode(Players.Value)

        if (#PlayersDecoded < 2) then
            continue
        end

        table.insert(Servers, {
            Job_Id = Server.Name;
            PlayerCount = #PlayersDecoded;
        })
    end

    table.sort(Servers, function(Result1, Result2)
        return Result1.PlayerCount < Result2.PlayerCount
    end)

    warn(Servers[1].Job_Id)
    ReplicatedStorage.Requests.JoinPublicServer:FireServer(Servers[1].Job_Id)
end

return Utility