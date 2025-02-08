local Drawification = {
    ListPosition = Vector2.new(5, 100);
    Drawings = {}
}

local ColorData = {
    warning = Color3.fromRGB(255, 236, 64);
    l_error = Color3.fromRGB(216, 33, 33);
    success = Color3.fromRGB(104, 238, 26);
}

function Drawification:Handle_Drawing(DrawingType, Properties)
    local Drawing = Drawing.new(DrawingType)

    for i,v in next, Properties do
        Drawing[i] = v
    end

    local Pos = #Drawification.Drawings + 1
    self.Drawings[Pos] = Drawing

    return Drawing
end

function Drawification:Shift(DrawingPosition)
    for i = DrawingPosition, #self.Drawings do
        local CurrentDrawing = self.Drawings[i]
        CurrentDrawing.Position = CurrentDrawing.Position - Vector2.new(0, 25)
    end

    self.ListPosition = self.ListPosition - Vector2.new(0, 25)
end

function Drawification:ClearNotifications()
    local Drawings = self.Drawings

    for i, Drawing in next, Drawings do
        pcall(Drawing.Remove, Drawing)
    end
end

function Drawification:RemoveDrawing(Drawing)
    local DrawingPosition = table.find(self.Drawings, Drawing)
    
    if not DrawingPosition then
        warn("drawing not found")
        return
    end
    
    pcall(Drawing.Remove, Drawing)
    table.remove(self.Drawings, DrawingPosition)

    self:Shift(DrawingPosition)
end

function Drawification:Notification(...)
    local Args = {...}

    local NotifyType = nil
    local NotifProperties = nil

    for i, v in next, Args do
        if (typeof(v) == "string") then
            NotifyType = v:lower()
        end
        
        if (typeof(v) == "table") then
            NotifProperties = v
        end
    end

    local RemovalTime = NotifProperties.Time
    local NotifColor = Color3.fromRGB(255, 255 ,255)

    if (ColorData[NotifyType] ~= nil) then
        NotifColor = ColorData[NotifyType]
    end
    
    local NotifDrawing = self:Handle_Drawing("Text", {
        Text = NotifProperties.Text or "[LIBRARY]: Test!";
        Font = NotifProperties.Font or 2;
        Size = NotifProperties.Size or 25;
        Center = NotifProperties.Center or false;
        Outline = NotifProperties.Outline or true;
        Color = NotifProperties.ForceColor or NotifColor;
    })

    NotifDrawing.Position = self.ListPosition
    NotifDrawing.Visible = true

    self.ListPosition = self.ListPosition + Vector2.new(0, 25)

    if (RemovalTime ~= nil and typeof(RemovalTime) == "number") then
        task.delay(RemovalTime, self.RemoveDrawing, self, NotifDrawing)
    end

    return {
        Remove = function()
            self:RemoveDrawing(NotifDrawing)
        end;

        ChangeText = function(NewText)
            NotifDrawing.Text = NewText
        end;
    }
end

return Drawification