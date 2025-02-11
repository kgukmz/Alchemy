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
            JobId = Server.Name;
            PlayerCount = #PlayersDecoded;
        })
    end

    table.sort(Servers, function(Result1, Result2)
        return Result1.PlayerCount < Result2.PlayerCount
    end)

    for i,v in next, Servers do
        warn(i, unpack(v))
    end

    if (Filter == "Any") then
        local RandomIndex math.random(1, #Servers)
        local Server = Servers[RandomIndex]
        JoinPublicServer:FireServer(Server.JobId)
    elseif (Filter == "Smallest") then
        local FirstIndex = Servers[1]
        JoinPublicServer:FireServer(FirstIndex.JobId)
    elseif (Filter == "Largest") then
        local LastIndex = Servers[#Servers]
        JoinPublicServer:FireServer(LastIndex.JobId)
    end
end

return Utility