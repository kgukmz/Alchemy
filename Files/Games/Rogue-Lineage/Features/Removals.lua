local Removals = {}

-- Get the Lighting service
local Lighting = game:GetService("Lighting")

-- Event module (assuming it's correctly implemented elsewhere)
local Event = require("Files/Utils/Event.lua")

-- Create event connections for property changes
local FullbrightConnect = Event:Create(Lighting:GetPropertyChangedSignal("Ambient"))
local FogEndConnect = Event:Create(Lighting:GetPropertyChangedSignal("FogEnd"))
local FogStartConnect = Event:Create(Lighting:GetPropertyChangedSignal("FogStart"))

local OrderFields = {}

-- Initialize the old values to current Lighting properties
local OldAmbient = Lighting.Ambient
local OldFogStart = Lighting.FogStart
local OldFogEnd = Lighting.FogEnd

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

        local FullbrightColor = Color3.fromRGB(190, 190, 190)
        Lighting.Ambient = FullbrightColor

        FullbrightConnect:Connect(function(NewValue)
            OldAmbient = NewValue
            print("Old Ambient:", OldAmbient, "New Ambient:", NewValue)
            
            Lighting.Ambient = FullbrightColor
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

        FogEndConnect:Connect(function(NewFogEnd)
            OldFogEnd = NewFogEnd
            print("Old FogEnd:", OldFogEnd, "New FogEnd:", NewFogEnd)
            Lighting.FogEnd = 999999
        end)

        FogStartConnect:Connect(function(NewFogStart)
            OldFogStart = NewFogStart
            print("Old FogStart:", OldFogStart, "Old FogEnd:", OldFogEnd)
            Lighting.FogStart = 0
        end)
    elseif (Value == false) then
        FogEndConnect:Disconnect()
        FogStartConnect:Disconnect()

        print("Restoring Fog values - OldFogEnd:", OldFogEnd, "OldFogStart:", OldFogStart)

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
