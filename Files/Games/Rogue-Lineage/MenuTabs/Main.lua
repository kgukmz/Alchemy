local Main = {}

function Main:Init(Window)
    local MainTab = Window:CreateTab({ Name = "MAIN" })
    MainTab:Separator({ Text = "MAIN" })
    
    local WorldHeader = MainTab:CollapsingHeader({ Title = "WORLD" })
    WorldHeader:Separator({ Text = "FULLBRIGHT" })
    WorldHeader:Checkbox({
        Label = "Enable Fullbright"
    })
    
    WorldHeader:Slider({
        Label = "Intensity";
        Value = 1;
        MinValue = 1;
        MaxValue = 10;
    })

    WorldHeader:Separator({ Text = "VISUALS" })
    WorldHeader:Checkbox({
        Label = "No Shadows"
    })
    
    WorldHeader:Checkbox({
        Label = "No Sanity"
    })

    WorldHeader:Checkbox({
        Label = "No Blur"
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

end

return Main