local Removals = {}

local Lighting = GetService("Lighting")

local FullbrightConnection
local FogStartConnection
local FogEndConnection

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

function Removals:Fullbright(Value) 
    if (Value == true) then
        OldAmbient = Lighting.Ambient
        
        local function SetAmbient()
            local FullbrightIntensity = getgenv().FullbrightIntensity or 255

            local Intensity = {}
            for i = 1, 3 do
                table.insert(Intensity, FullbrightIntensity)
            end

            Lighting.Ambient = Color3.fromRGB(table.unpack(Intensity)) 
        end

        SetAmbient()

        FullbrightConnection = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
            OldAmbient = Lighting.Ambient
            SetAmbient()
        end)
    elseif (Value == false) then
        if (FullbrightConnection ~= nil) then
            FullbrightConnection:Disconnect()
            FullbrightConnection = nil
        end

        if (not OldAmbient ~= nil) then
            Lighting.Ambient = OldAmbient
        end
        
        print(FullbrightConnection)
        print(OldAmbient)
    end
end

function Removals:NoFog(Value)
    if (Value == true) then
        
    elseif (Value == false) then
        if (FogStartConnection ~= nil) then
            FogStartConnection:Disconnect()
            FogStartConnection = nil
        end

        if (FogEndConnection ~= nil) then
            FogEndConnection:Disconnect()
            FogEndConnection = nil
        end

        if (OldFogStart ~= nil) then
            
        end

        if (OldFogEnd ~= nil) then
            
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