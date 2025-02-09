local DrawingESP = {
    Cache = {};
}

local RunService = cloneref(game:GetService("RunService"))
local Workspace = cloneref(game:GetService("Workspace"))

local CurrentCamera = Workspace.CurrentCamera

function Handle_Drawing(Type, Properties)
    local DrawingObj = Drawing.new(Type)

    for Property, Value in next, Properties do
        DrawingObj[Property] = Value
    end

    DrawingESP.Cache[#DrawingESP.Cache+1] = DrawingObj

    return DrawingObj
end

function DrawingESP:Add_Player(Player)
    local EspData = {
        Player = Player;
        Drawings = {};
    }

    EspData.Drawings.NameDrawing = Handle_Drawing("Text", {
        Text = "[" .. Player.Name .. "]";
        Font = 2,
        Color = Color3.fromRGB(255,255,255);
        Size = 16;
        Outline = true;
        Center = true,
    })
    
    EspData.Connection = RunService.RenderStepped:Connect(function()
        local EspPlayer = EspData.Player

        if (EspData.Player == nil or EspPlayer.Character == nil) then
            return
        end

        if (EspPlayer.Character == nil or EspPlayer.Character:FindFirstChild("Head") == nil) then
            return
        end

        local ScreenPos = CurrentCamera:WorldToViewportPoint(EspPlayer.Character.Head.Position)

        if (EspData.Drawings.NameDrawing ~= nil) then
            EspData.Drawings.NameDrawing.Position = Vector2.new(ScreenPos.X / 2, ScreenPos.Y)
            EspData.Drawings.NameDrawing.Visible = true
        end
    end)

    self.Cache[#self.Cache+1] = EspData

    return EspData
end

--// DrawingESP:Add_Player(game.Players.ForbiddenBots)

return DrawingESP