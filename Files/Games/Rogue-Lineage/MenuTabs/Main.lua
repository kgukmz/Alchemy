local Main = {}

function Main:Init(Window)
    local MainTab = Window:CreateTab({ Name = "MAIN" })
    MainTab:Separator({ Text = "MAIN" })
    
    -- // World Header

    local WorldHeader = MainTab:CollapsingHeader({ Title = "WORLD" })
    WorldHeader:Separator({ Text = "FULLBRIGHT" })
    WorldHeader:Checkbox({
        Label = "Enable Fullbright"
    })
    
    WorldHeader:Slider({
        Label = "[Intensity]";
        Value = 1;
        MinValue = 1;
        MaxValue = 10;
    })

    WorldHeader:Separator({ Text = "VISUALS" })
    WorldHeader:Checkbox({
        Label = "No Shadows"
    })
    
    WorldHeader:Checkbox({
        Label = "No Visual Defects" -- // No sanity, no blur
    })

    WorldHeader:Checkbox({
        Label = "No Fog"
    })

    WorldHeader:Separator({ Text = "REMOVALS" })
    WorldHeader:Checkbox({
        Label = "Remove Orderly Fields"
    })

    WorldHeader:Checkbox({
        Label = "Disable Killbricks"
    })

    WorldHeader:Checkbox({
        Label = "Disable Poison Bricks"
    })
end

return Main