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

function Utility:ServerHop(Data)
    local Region = Data.Region or nil
    local Filter = Data.Filter or nil

    print("Region:", Region, "Filter:", Filter)

    local ServerInfo = ReplicatedStorage.ServerInfo
    local JoinPublicServer = ReplicatedStorage.Requests.JoinPublicServer
    local Servers = {}

    for i, Server in ServerInfo:GetChildren() do
        local PlayerInfo = Server:FindFirstChild("Players")
        local PlayersDecoded = HttpService:JSONDecode(PlayerInfo.Value)
        local ServerRegion = Server:FindFirstChild("Region")

        if (Region ~= nil and ServerRegion.Value ~= Region) then
            --  print("Region isn't", Region "?", ServerRegion.Value)
            continue
        end

        if (#PlayersDecoded < 3) then
            continue
        end

        if (#PlayersDecoded == Players.MaxPlayers) then
            continue
        end

        table.insert(Servers, {
            JobId = Server.Name;
            PlayerCount = #PlayersDecoded;
        })
    end

    table.sort(Servers, function(Result1, Result2)
        return Result1.PlayerCount < Result2.PlayerCount
    end)

    if (Filter == "Any") then
        local RandomIndex = Servers[math.random(1, #Servers)]
        print(RandomIndex.PlayerCount)
        JoinPublicServer:FireServer(RandomIndex.JobId)
    elseif (Filter == "Smallest") then
        local FirstIndex = Servers[1]
        print(FirstIndex.PlayerCount)
        JoinPublicServer:FireServer(FirstIndex.JobId)
    elseif (Filter == "Largest") then
        local LastIndex = Servers[#Servers]
        print(LastIndex.PlayerCount)
        JoinPublicServer:FireServer(LastIndex.JobId)
    end
end

return Utility