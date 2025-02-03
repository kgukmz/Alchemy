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
    local AutomationTab = Window:Tab({ Name = "Automation" })
    local SettingsTab = Window:Tab({ Name = "Settings" })

    do -- // Main
       local MovementSection = MainTab:Section({ Name = "Movement" })
       
       local ClientSection = MainTab:Section({ Name = "Client" })

       local WorldInteractionsSection = MainTab:Section({ Name = "World Interaction" })
       
       local WorldVisualsSection = MainTab:Section({ Name = "World Visuals" })
    end
end

return Interface