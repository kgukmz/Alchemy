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
    if (Value == true) then
        NofallCheck:Connect(function()
            local Character = LocalPlayer.Character

            if (Character == nil) then
                return
            end

            local RightLeg = Character:FindFirstChild("Right Leg")
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

            if (Character == nil or HumanoidRootPart == nil) then
                return
            end

            local DustParticle = HumanoidRootPart:FindFirstChild("DUST")

            if (DustParticle ~= nil and DustParticle.ClassName == "ParticleEmitter") then
                DustParticle:Destroy()

                local FakeDustInstance = Instance.new("Sound")
                FakeDustInstance.Name = "DUST"
                FakeDustInstance.Parent = HumanoidRootPart
            end

            -- // boost performance by destroying unused dust instances created by inputhandler
            if (RightLeg ~= nil and RightLeg:FindFirstChild("DUST")) then
                local DustSound = RightLeg.DUST
                DustSound:Destroy()
            end
        end)
    elseif (Value == false) then
        NofallCheck:Disconnect()

        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

        if (HumanoidRootPart == nil) then
            return
        end

        local DustInstance = HumanoidRootPart:FindFirstChild("DUST")

        if (DustInstance ~= nil and DustInstance.ClassName == "Sound") then
            DustInstance:Destroy()
            
            local NewDustInstance = ReplicatedStorage.CharacterSoundFiles:FindFirstChild("DUST")
            NewDustInstance = NewDustInstance:Clone()
            NewDustInstance.Parent = HumanoidRootPart
        end
    end
end

function Removals:DisableKillBricks(Value)
    local MapFolder = workspace:FindFirstChild("Map")
    
    if (MapFolder == nil) then
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
        for i, Object in pairs(MapFolder:GetChildren()) do
            if (Object:FindFirstChild("TouchInterest") == nil) then
                continue
            end

            if (table.find(AllowedParts, Object.Name)) then
                continue
            end

            Object.CanTouch = false
        end
    elseif (Value == false) then
        for i, Object in pairs(MapFolder:GetChildren()) do
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
    local MapFolder = workspace:FindFirstChild("Map")
    
    if (MapFolder == nil) then
        return
    end

    if (Value == true) then
        for i, Object in pairs(MapFolder:GetChildren()) do
            if (Object.Name ~= "PoisonField") then
                continue
            end

            Object.CanTouch = false
        end   
    elseif (Value == false) then
        for i, Object in pairs(MapFolder:GetChildren()) do
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
        for i, Object in pairs(MapFolder:GetChildren()) do
            if (Object.Name ~= "OrderField" and Object.Name ~= "MageField") then
                continue
            end

            Object.Parent = nil
            table.insert(OrderFieldCache, Object)
        end
    elseif (Value == false) then
        for i = 1, #OrderFieldCache do
            local OrderField = OrderFieldCache[i]
            OrderField.Parent = workspace.Map
            OrderFieldCache[i] = nil
        end
    end
end

function Removals:DisableVisualDefects(Value)
    local Blindness = Lighting:WaitForChild("Blindness", true)
    local Blur = Lighting:WaitForChild("Blur", true)

    Blindness.Enabled = (not Value)
    Blur.Enabled = (not Value)
end

return Removals
