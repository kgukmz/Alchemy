local Main = {}

local Removals = require("Files/Games/Rogue-Lineage/Features/Removals.lua")

function Main:Init(Window)
    local MainTab = Window:CreateTab({ Name = "MAIN" })
    MainTab:Separator({ Text = "MAIN" })
    
    -- // World Header

    local WorldHeader = MainTab:CollapsingHeader({ Title = "WORLD" })
    WorldHeader:Separator({ Text = "FULLBRIGHT" })
    WorldHeader:Checkbox({
        Label = "Enable Fullbright";
        Callback = Removals.Fullbright
    })
    
    WorldHeader:Slider({
        Label = "[Intensity]";
        Value = 0;
        MinValue = 0;
        MaxValue = 255;
    })

    WorldHeader:Separator({ Text = "VISUALS" })
    WorldHeader:Checkbox({
        Label = "No Shadows";
        Callback = Removals.NoShadows
    })
    
    WorldHeader:Checkbox({
        Label = "No Visual Defects"; -- // No sanity, no blur
        Callback = Removals.NoVisualDefects;
    })

    WorldHeader:Checkbox({
        Label = "No Fog";
    })

    WorldHeader:Separator({ Text = "REMOVALS" })
    WorldHeader:Checkbox({
        Label = "Remove Orderly Fields";
        Callback = Removals.RemoveOrderFields;
    })

    WorldHeader:Checkbox({
        Label = "Disable Killbricks"
    })

    WorldHeader:Checkbox({
        Label = "Disable Poison Bricks"
    })
end

return Main