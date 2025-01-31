local Removals = {}

local Players = GetService("Players")
local Lighting = GetService("Lighting")
local RunService = GetService("RunService")
local ReplicatedStorage = GetService("ReplicatedStorage")

local Event = require("Files/Utils/Event.lua")

local LocalPlayer = Players.LocalPlayer

local NofallCheck = Event:Create(RunService.Heartbeat)

local OrderFieldCache = {}
local OldDustInstance
local FakeDust

function Removals:DisableFallDamage(Value)
    if (Value == false) then
        return
    end

    if (Value == true) then
        NofallCheck:Connect(function()
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

            if (Character == nil or HumanoidRootPart == nil) then
                return
            end

            local DustInstance = HumanoidRootPart:FindFirstChild("DUST")

            if (DustInstance ~= nil and DustInstance.ClassName == "ParticleEmitter") then
                DustInstance:Destroy()

                if (FakeDust ~= nil) then
                    FakeDust:Destroy()
                    FakeDust = nil
                end
                
                FakeDust = Instance.new("Sound")
                FakeDust.Name = "DUST"
                FakeDust.Parent = HumanoidRootPart
            end
        end)
    elseif (Value == false) then
        NofallCheck:Disconnect()

        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

        if (HumanoidRootPart == nil) then
            return
        end

        if (FakeDust ~= nil) then
            FakeDust:Destroy()
            FakeDust = nil
        end

        local NewDustInstance = ReplicatedStorage.CharacterSoundFiles:FindFirstChild("DUST")
        NewDustInstance = NewDustInstance:Clone()
        NewDustInstance.Parent = HumanoidRootPart
    end
end

function Removals:DisableKillBricks(Value)
    local Map = workspace:FindFirstChild("Map")
    
    if (Map == nil) then
        return
    end

    local AllowedParts = {
        "Fire";
        "SolansGate";
        "SolanBall";
        "Elevator";
        "TeleportIn";
        "TeleportOut";
        "BaalField";
        "OrderField";
        "MageField";
        "PoisonField";
    }

    if (Value == true) then
        for i, Object in pairs(Map:GetChildren()) do
            if (Object:FindFirstChild("TouchInterest") == nil) then
                continue
            end

            if (table.find(AllowedParts, Object.Name)) then
                continue
            end

            Object.CanTouch = false
        end
    elseif (Value == false) then
        for i, Object in pairs(Map:GetChildren()) do
            if (Object:FindFirstChild("TouchInterest") == nil) then
                continue
            end

            if (table.find(AllowedParts, Object.Name)) then
                continue
            end

            Object.CanTouch = true
        end
    end
end

function Removals:DisablePoisonPits(Value)
    local Map = workspace:FindFirstChild("Map")
    
    if (Map == nil) then
        return
    end

    if (Value == true) then
        for i, Object in pairs(Map:GetChildren()) do
            if (Object.Name ~= "PoisonField") then
                continue
            end

            Object.CanTouch = false
        end   
    elseif (Value == false) then
        for i, Object in pairs(Map:GetChildren()) do
            if (Object.Name ~= "PoisonField") then
                continue
            end

            Object.CanTouch = true
        end
    end
end

function Removals:RemoveOrderFields(Value)
    local MapFolder = workspace:FindFirstChild("Map")

    if (Value == true) then
        if (MapFolder == nil) then
            return
        end

        for i, Object in pairs(MapFolder:GetChildren()) do
            if (Object.Name == "OrderField" or Object.Name == "MageField") then
                Object.Parent = nil
                table.insert(OrderFieldCache, Object)
            end
        end
    elseif (Value == false) then
        if (#OrderFieldCache == 0) then
            return
        end

        for i, OrderField in pairs(OrderFieldCache) do
            local OrderFieldCached = OrderFieldCache[i]
            OrderFieldCached.Parent = workspace.Map
            table.remove(OrderField, i)
        end
    end
end

function Removals:DisableVisualDefectsToggle(Value)
    local Blindness = Lighting:WaitForChild("Blindness", true)
    local Chokeout = Lighting:WaitForChild("Chokeout", true)
    local BagBlind = Lighting:WaitForChild("BagBlind", true)
    local Blur = Lighting:WaitForChild("Blur", true)

    Blindness.Enabled = (not Value)
    Chokeout.Enabled = (not Value)
    BagBlind.Enabled = (not Value)
    Blur.Enabled = (not Value)
end

return Removals
