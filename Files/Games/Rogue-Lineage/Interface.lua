local Interface = {}

function Interface:Setup(Library)
    local Window = Library:Window({
        Name = "Alchemy",
        Watermark = false,
        Keybinds = false,
        Selects = true,
        Size = Vector2.new(550, 480)
    })
    
    local MainTab = Window:Tab({ Name = "Main" })

    do -- // Main
       local MovementSection = MainTab:Section({ Name = "Movement" })
       
       
    end
end

return Interface