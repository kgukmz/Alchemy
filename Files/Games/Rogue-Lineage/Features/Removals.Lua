local Removals = {}

local OrderFieldCache = {}

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

        warn("unadded")
    elseif (Value == false) then
        if (#OrderFieldCache == 0) then
            return
        end

        for i, OrderField in next, OrderFieldCache do
            local OrderFieldCached = OrderField[i]
            OrderFieldCached.Parent = workspace.Map
            table.remove(OrderField, i)
        end

        warn("readded")
    end
end

return Removals