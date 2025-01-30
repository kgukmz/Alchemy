local Main = {}

function Main:MovementGroup(WindowTab)
    local MovementGroup = WindowTab:AddLeftGroupbox("[ MOVEMENT ]")
    MovementGroup:AddToggle("FlyToggle", { Text = "Enable Fly"; })
    MovementGroup:AddSlider("FlyVelSlider", {
        Text = "Velocity";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 125;
        Compact = true;
    })

    MovementGroup:AddToggle("AutoFallToggle", { Text = "Use Auto Fall"; })
    MovementGroup:AddSlider("AutoFallSlider", {
        Text = "Speed";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 20;
        Compact = true;
    })

    MovementGroup:AddDivider()

    MovementGroup:AddToggle("SpeedToggle", { Text = "Enable Speed"; })
    MovementGroup:AddSlider("SpeedVelSlider", {
        Text = "Velocity";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 125;
        Compact = true;
    })

    MovementGroup:AddDivider()

    MovementGroup:AddToggle("InfiniteJumpToggle", { Text = "Enable Infinite Jump"; })
    MovementGroup:AddSlider("InfiniteJumpSlider", {
        Text = "Velocity";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 125;
        Compact = true;
    })
end

function Main:ClientGroup(WindowTab)
    local ClientGroup = WindowTab:AddRightGroupbox("[ CLIENT ]")

    ClientGroup:AddToggle("DisableFallDamageToggle", { Text = "Disable Fall Damage"; })
    ClientGroup:AddToggle("DisableKillBricksToggle", { Text = "Disable Kill Bricks"; })
    ClientGroup:AddToggle("DisablePoisonPitsToggle", { Text = "Disable Poison Pits"; })
    ClientGroup:AddToggle("DisableVisualDefectsToggle", { Text = "Disable Visual Defects"; })
    ClientGroup:AddToggle("RemoveOrderlyFieldsToggle", { Text = "Remove Orderly Fields"; })

    ClientGroup:AddDivider()

    ClientGroup:AddDropdown("KillMethodDropdown", {
        Values = {
            "Regular";
            "Solans";
            "Killbrick";
        };

        Default = 1;
        Multi = false;
        Tooltip = "Select a kill method"
    })

    --[[ FIX BUTTONS LATER
    ClientGroup:AddButton("ResetButton", {
        Text = "Reset";
    })

    ClientGroup:AddButton("KillSelfButton", {
        Text = "Kill Self";
        DoubleClick = true;
        Tooltip = "[ THIS FEATURE CAN AND WILL TAKE LIVES ]";
    })
    --]]
end

function Main:WorldVisualsGroup(WindowTab)
    local WorldVisualsGroup = WindowTab:AddLeftGroupbox("[ WORLD VISUALS ]")

    WorldVisualsGroup:AddToggle("DisableAmbientToggle", { Text = "Disable Ambient"; })
    WorldVisualsGroup:AddSlider("AmbientIntensitySlider", {
        Text = "Intensity";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 255;
        Compact = true;
    })

    WorldVisualsGroup:AddDivider()

    WorldVisualsGroup:AddToggle("Disable Fog")
end

function Main:Init(Window)
    local MainTab = Window:AddTab("[ MAIN ]")

    Main:MovementGroup(MainTab)
    Main:ClientGroup(MainTab)
    Main:WorldVisualsGroup(MainTab)
end

return Main