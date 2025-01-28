local Main = {}

function Main:Init(Window)
    local MainTab = Window:CreateTab({ Name = "MAIN" })
    MainTab:Separator({ Text = "MAIN" })

    local WorldHeader = MainTab:CollapsingHeader({ Title = "WORLD" })
    WorldHeader:Checkbox({
        Label = "Enable Fullbright"
    })
    
    WorldHeader:Slider({
        Label = "Intensity";
        Value = 1;
        MinValue = 1;
        MaxValue = 10;
    })

    WorldHeader:Separator({ Text = "TOGGLES" })
    WorldHeader:Checkbox({
        Label = "No Shadows"
    })
    
    WorldHeader:Checkbox({
        Label = ""
    })
end

return Main