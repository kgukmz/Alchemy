local Removals = {}

local Lighting = GetService("Lighting")

local Event = require("Files/Utils/Event.lua")

local FullbrightConnect = Event:Create(Lighting:GetPropertyChangedSignal("Ambient"))
local FogEndConnect = Event:Create(Lighting:GetPropertyChangedSignal("FogEnd"))
local FogStartConnect = Event:Create(Lighting:GetPropertyChangedSignal("FogStart"))

local OrderFields = {}

local OldAmbient
local OldFogStart
local OldFogEnd

function Removals:RemoveOrderFields(Value)
    if (getgenv().getinstances == nil) then
        warn("Executor does not support getinstances")
        return
    end
    
    if (Value == true) then
        for i, Object in next, getinstances() do
            if (Object.Name ~= "OrderField" and Object.Name ~= "MageField") then
                continue
            end

            if (not table.find(OrderFields, Object)) then
                table.insert(OrderFields, Object) 
            end

            Object.Parent = nil
        end
    elseif (Value == false) then
        if (#OrderFields == 0) then
            return
        end
        
        for i, Object in next, OrderFields do
            Object.Parent = workspace.Map
        end
    end
end

function Removals:RemoveAmbient(Value) 
    if (Value == true) then
        OldAmbient = Lighting.Ambient
        
        local Intensity = getgenv().FullbrightIntensity or 200, 200, 200
        Lighting.Ambient = Color3.fromRGB(Intensity, Intensity, Intensity)

        FullbrightConnect:Connect(function(NewAmbient)
            OldAmbient = NewAmbient
            
            local Intensity = getgenv().FullbrightIntensity or 200, 200, 200
            Lighting.Ambient = Color3.fromRGB(Intensity, Intensity, Intensity)
        end)
    elseif (Value == false) then
        FullbrightConnect:Disconnect()

        if (OldAmbient ~= nil) then
            Lighting.Ambient = OldAmbient
        end
    end
end

function Removals:NoFog(Value)
    if (Value == true) then
        OldFogStart = Lighting.FogStart
        OldFogEnd = Lighting.FogEnd

        Lighting.FogEnd = 999999
        Lighting.FogStart = 0

        FogEndConnect:Connect(function(NewFog)
            OldFogEnd = NewFog
            Lighting.FogEnd = 999999
        end)

        FogStartConnect:Connect(function(NewFog)
            OldFogStart = NewFog
            Lighting.FogStart = 0
        end)
    elseif (Value == false) then
        FogEndConnect:Disconnect()
        FogStartConnect:Disconnect()

        if (OldFogEnd ~= nil) then
            Lighting.FogEnd = OldFogEnd
        end

        if (OldFogStart ~= nil) then
            Lighting.FogStart = OldFogStart
        end
    end
end

function Removals:NoVisualDefects(Value)
    local Blindness = Lighting:WaitForChild("Blindness", true)

    if (Blindness ~= nil) then
        Blindness.Enabled = not Value
    end

    local Sanity = Lighting:WaitForChild("Sanity", true)

    if (Sanity ~= nil) then
        Sanity.Enabled = not Value    
    end

    local Blur = Lighting:WaitForChild("Blur", true)

    if (Blur ~= nil) then
        Blur.Enabled = not Value
    end
end

function Removals:NoShadows(Value)
    Lighting.GlobalShadows = not Value
end

return Removals