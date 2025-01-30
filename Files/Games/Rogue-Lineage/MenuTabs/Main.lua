local Main = {}
local TabGroups = {}

function TabGroups:Movement(WindowTab)
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

function TabGroups:Client(WindowTab)
    local ClientGroup = WindowTab:AddRightGroupbox("[ CLIENT ]")

    ClientGroup:AddToggle("AntiFireToggle", { Text = "Enable Anti Fire"; })
    ClientGroup:AddToggle("AntiInjuriesToggle", { Text = "Enable No Injuries"; })

    ClientGroup:AddDivider()

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

function TabGroups:WorldInteractions(WindowTab)
    local WorldInteractionsGroup = WindowTab:AddLeftGroupbox("[ WORLD INTERACTIONS ]")

    WorldInteractionsGroup:AddToggle("BagPickupToggle", { Text = "Bag Pickup"; })
    WorldInteractionsGroup:AddSlider("BagPickupRangeSlider", {
        Text = "Range";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 100;
        Compact = true;
    })

    WorldInteractionsGroup:AddDropdown("BagPickupTypeDropdown", {
        Text = "Bag Pickup Type";
        Values = {
            "Artifacts";
            "Silver";
            "Other";
        };

        Default = 1;
        Multi = true;
    })

    WorldInteractionsGroup:AddDivider()

    WorldInteractionsGroup:AddToggle("AutoPickupTrinketsToggle", { Text = "Auto Pickup Trinkets"; })
    WorldInteractionsGroup:AddToggle("AutoPickupIngredientsToggle", { Text = "Auto Pickup Ingredients"; })
end

function TabGroups:WorldVisuals(WindowTab)
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

    WorldVisualsGroup:AddToggle("DisableFogToggle", { Text = "Disable Fog"; })
end

function TabGroups:ManaUtilities(WindowTab)
    local ManaUtilitiesGroup = WindowTab:AddRightGroupbox("[ MANA UTILITIES ]")

    ManaUtilitiesGroup:AddToggle("ManaChargeToggle", { Text = "Begin Mana Charge"; })
    ManaUtilitiesGroup:AddSlider("ManaChargeSlider", {
        Text = "Mana %";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 100;
        Compact = true;
    })

    ManaUtilitiesGroup:AddDivider()

    ManaUtilitiesGroup:AddToggle("AutoSpellTrain", { Text = "Auto Spell Training"; })
    ManaUtilitiesGroup:AddToggle("AutoClimbTrainToggle", { Text = "Auto Climb Training"; })
    ManaUtilitiesGroup:AddToggle("AntiSpellBackfireToggle", { Text = "Anti Spell Backfire"; })

    ManaUtilitiesGroup:AddDivider()

    ManaUtilitiesGroup:AddLabel("[ AIMBOT FEATURES ]")

    ManaUtilitiesGroup:AddDropdown("SpellAimbotDropdown", {
        Values = {
            "Armis";
            "Inferi";
            "Fimbulvetr";
            "Manus Dei";
        };

        Default = 1;
        Multi = true;
        Tooltip = "[ SELECT AIMBOT FOR SPELLS ]"
    })

    ManaUtilitiesGroup:AddToggle("SpellAimbotToggle", { Text = "Enable Spell Aimbot"; })
end

function Main:Init(Window)
    local MainTab = Window:AddTab("[ MAIN ]")

    TabGroups:Movement(MainTab)
    TabGroups:Client(MainTab)
    TabGroups:WorldInteractions(MainTab)
    TabGroups:WorldVisuals(MainTab)
    TabGroups:ManaUtilities(MainTab)
end

return Main