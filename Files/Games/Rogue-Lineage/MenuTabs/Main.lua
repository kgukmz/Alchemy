local Main = {}

function Main:Init(Window)
    local MainTab = Window:AddTab("[MAIN]")

    local MovementGroup = MainTab:AddLeftGroupbox("MOVEMENT")
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

return Main