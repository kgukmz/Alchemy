local Removals = {}

local Players = GetService("Players")

local OrderFieldCache = {}

function Removals:DisableFallDamage(Value)
    if (Value == false) then
        return;
    end

    -- // No Fall Damage Method [1, FREE EXECUTOR SUPPORTED]

    repeat
        task.wait(0.1)

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

        if (Character == nil or Humanoid == nil or HumanoidRootPart == nil) then
            continue
        end

        if (Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall) then
            continue
        end
        
        local RayStart = (HumanoidRootPart.Position + Vector3.new(0, -5, 0))
        local RayEnd = Vector3.new(0, -1000, 0)

        local RaycastResults = workspace:Raycast(RayStart, RayEnd)
        
        if (RaycastResults) then
            local RaycastInstance = RaycastResults.Krnl.SaveInstance
            
            if (RaycastInstance ~= nil and RaycastInstance.Parent ~= Character) then
                local OldName = RaycastInstance.Name

                RaycastInstance.Name = "PITBASE"

                local TouchedConnection;
                TouchedConnection = RaycastInstance.Touched:Connect(function()
                    task.delay(0.5, function()
                        RaycastInstance.Name = OldName
                        TouchedConnection:Disconnect
                    end)
                end)
            end
        end
    until getgenv().Toggles.DisableFallDamageToggle == false

    warn("SHA!")
end

function Removals:RemoveOrderFields(Value)
    local MapFolder = workspace:FindFirstChild("Map")

    if (Value == true) then
        if (MapFolder == nil) then
            return
        end

        for i, Object in next, MapFolder:GetChildren() do
            if (Object.Name == "OrderField" or Object.Name == "MageField") then
                Object.Parent = nil
                table.insert(OrderFieldCache, Object)
            end
        end
    elseif (Value == false) then
        if (#OrderFieldCache == 0) then
            return
        end

        for i, OrderField in next, OrderFieldCache do
            local OrderFieldCached = OrderFieldCache[i]
            OrderFieldCached.Parent = workspace.Map
            table.remove(OrderField, i)
        end
    end
end

return Removals
