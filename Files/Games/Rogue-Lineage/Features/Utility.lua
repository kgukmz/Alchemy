local Utility = {}

local ReplicatedStorage = GetService("ReplicatedStorage")
local HttpService = GetService("HttpService")
local Players = GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

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

function Utility:ServerHop(Data)
    local Region = Data.Region or nil
    local Filter = Data.Filter or nil

    local ServerInfo = ReplicatedStorage.ServerInfo
    local JoinPublicServer = ReplicatedStorage.Requests.JoinPublicServer
    local Servers = {}

    for i, Server in ServerInfo do
        local Players = Server:FindFirstChild("Players")
        local PlayersDecoded = HttpService:JSONDecode(Players.Value)

        if (Region ~= nil) then
            local ServerRegion = Server:FindFirstChild("Region")

            if (ServerRegion.Value ~= Region) then
                continue
            end
        end

        if (#PlayersDecoded < 2) then
            continue
        end

        if (#PlayersDecoded == Players.MaxPlayers) then
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

    if (Filter ~= nil) then
        if (Filter == "Smallest") then
            JoinPublicServer:FireServer(Servers[1].Job_Id)
        elseif (Filter == "Largest") then
            pcall(warn, Servers[#Servers], Servers[#Servers].Job_Id)
            JoinPublicServer:FireServer(Servers[#Servers].Job_Id)
        elseif (Filter == "Any") then
            local RandomIndex = math.random(1, #PlayersDecoded)    
            JoinPublicServer:FireServer(Servers[RandomIndex].Job_Id)
        end
    end    
end

return Utility