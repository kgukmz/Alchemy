local Main = {}

function Main:MovementGroup(Tab)
    local MovementGroup = Tab:AddLeftGroupbox("[ MOVEMENT ]")
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

function Main:ClientGroup(Tab)
    local ClientGroup = Tab:AddRightGroupbox("[ CLIENT ]")

    ClientGroup:AddDropdown("KillMethodDropdown", {
        Values = {
            "Regular";
            "Solans";
            "Killbrick";
        };

        Default = 1;
        Multi = false;
        Tooltip = "Select a kill method [ THIS WILL TAKE LIVES ]"
    })
    ClientGroup:AddButton("Reset")
    ClientGroup:AddButton("Kill Self")
end

function Main:Init(Window)
    local MainTab = Window:AddTab("[ MAIN ]")

    self:MovementGroup(MainTab)
    self:ClientGroup(MainTab)
end

return Main