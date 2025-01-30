local Main = {}

function Main:Init(Window)
    local MainTab = Window:AddTab("MAIN")
    local MovementGroup = MainTab:AddLeftGroupbox("MOVEMENT")

    MovementGroup:AddToggle("FlyToggle", {
        Text = "Enable Fly";
    })

    MovementGroup:AddSlider("FlySlider", {
        Text = "Velocity";
        Default = 0;
        Min = 0;
        Max = 150;
        Compact = true;
    })

    MovementGroup:AddToggle("FlyToggle", {
        Text = "Enable Auto Fall";
    })

    MovementGroup:AddSlider("FlySlider", {
        Text = "Speed";
        Default = 0;
        Min = 0;
        Max = 150;
        Compact = true;
    })

    MovementGroup:AddDivider()

    MovementGroup:AddToggle("SpeedToggle", {
        Text = "Enable Speed";
    })

    MovementGroup:AddSlider("SpeedSlider", {
        Text = "Velocity";
        Default = 0;
        Min = 0;
        Max = 125;
        Compact = true;
    })

    MovementGroup:AddDivider()

    MovementGroup:AddToggle("InfiniteJumpToggle", {
        Text = "Enable Infinite Jump";
    })

    MovementGroup:AddSlider("InfiniteJumpSplider", {
        Text = "Velocity";
        Default = 0;
        Min = 0;
        Max = 100;
        Compact = true;
    })

    local ClientGroup = MainTab:AddRightGroupbox("CLIENT")
    
    ClientGroup:AddToggle("NoFallToggle", {
        Text = "No Fall Damage";
    })

    ClientGroup:AddToggle("NoKillBricksToggle", {
        Text = "No Kill Bricks";
    })

    ClientGroup:AddToggle("NoAcidToggle", {
        Text = "No Acid Pits";
    })

    ClientGroup:AddToggle("NoFallToggle", {
        Text = "No Jump Penalty";
    })

    ClientGroup:AddToggle("RemoveVisualDefects", {
        Text = "No Visual Defects";
    })
end

return Main