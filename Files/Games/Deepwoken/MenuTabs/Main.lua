local Main = {}

function Main:Init(Window)
    local MainTab = Window:AddTab("Main")
    local MovementGroup = MainTab:AddLeftGroupbox("Movement")

    MovementGroup:AddToggle("FlyToggle", {
        Text = "Fly";
    })

    MovementGroup:AddSlider("FlySlider", {
        Text = "Velocity";
        Default = 0;
        Min = 0;
        Max = 150;
        Compact = true;
    })

    MovementGroup:AddDivider()

    MovementGroup:AddToggle("SpeedToggle", {
        Text = "Speed";
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
        Text = "Infinite Jump";
    })

    MovementGroup:AddSlider("InfiniteJumpSplider", {
        Text = "Velocity";
        Default = 0;
        Min = 0;
        Max = 100;
        Compact = true;
    })
end

return Main