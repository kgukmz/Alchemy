local Removals = {}

local Players = GetService("Players")
local Lighting = GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

local OrderFieldCache = {}
local OldDustInstance
local FakeDust

function Removals:DisableFallDamage(Value)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", true)

    if (Value == true) then
        local DustInstance = HumanoidRootPart:FindFirstChild("DUST")
        OldDustInstance = DustInstance
        DustInstance.Parent = nil
        
        FakeDust = Instance.new("Weld")
        FakeDust.Name = "DUST"
        FakeDust.Parent = HumanoidRootPart
    elseif (Value == false) then
        if (OldDustInstance ~= nil) then
            FakeDust:Destroy()
            FakeDust = nil

            OldDustInstance.Parent = HumanoidRootPart
        end
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
