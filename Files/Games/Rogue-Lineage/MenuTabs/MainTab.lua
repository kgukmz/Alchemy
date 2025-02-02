local Main = {}
local TabGroups = {}

local Removals = require("Files/Games/Rogue-Lineage/Features/Removals.lua")
local Movement = require("Files/Games/Rogue-Lineage/Features/Movement.lua")

function TabGroups:Movement(Library, WindowTab)
    local MovementSection = WindowTab:Section("[ MOVEMENT ]")

    do -- // Movement Section
        MovementSection:Toggle({ Name = "Enable Fly", Flag = "EnableFlyToggle", Callback = function(...)
           print(unpack({...})) 
        end})

        MovementSection:Slider({
            Name = "Velocity",
            Suffix = "%",
            Value = 0,
            Flag = "FlyVelocitySlider",
            Min = 0,
            Max = 125,
            Float = 1
        })

        MovementSection:Toggle({ Name = "Enable Speed", Flag = "EnableSpeedToggle", Callback = function(...)
            print(unpack({...})) 
         end})
 
         MovementSection:Slider({
             Name = "Velocity",
             Suffix = "%",
             Value = 0,
             Flag = "SpeedVelocitySlider",
             Min = 0,
             Max = 125,
             Float = 1
         })

         MovementSection:Toggle({
            Name = "Enable Infinite Jump",
            Flag = "EnableInfiniteJumpToggle",
            Callback = Movement.InfiniteJump
        })
 
         MovementSection:Slider({
             Name = "Velocity",
             Suffix = "%",
             Value = 0,
             Flag = "InfiniteJumpVelocitySlider",
             Min = 0,
             Max = 150,
             Float = 1
         })
    end
end

function TabGroups:Client(Library, WindowTab)
    local ClientSection = WindowTab:Section({ Name = "[ CLIENT ] "; })

    ClientSection:Toggle({
        Name = "Enable Anti Fire",
        Flag = "EnableAntiFireToggle",
    })

    ClientSection:Toggle({
        Name = "Enable No Injuries",
        Flag = "EnableNoInjuriesToggle",
    })

    ClientSection:Toggle({
        Name = "Disable Fall Damage",
        Flag = "DisableFallDamageToggle",
        Callback = Removals.DisableFallDamage,
    })

    ClientSection:Toggle({
        Name = "Disable Kill Bricks",
        Flag = "DisableKillBricksToggle",
        Callback = Removals.DisableKillBricks,
    })

    ClientSection:Toggle({
        Name = "Disable Poison Pits",
        Flag = "DisablePoisonPitsToggle",
        Callback = Removals.DisablePoisonPits,
    })

    ClientSection:Toggle({
        Name = "Remove Order Fields",
        Flag = "RemoveOrderFieldsToggle",
        Callback = Removals.RemoveOrderFields,
    })
end

function TabGroups:WorldFunctions(WindowTab)
    local WorldGroup = WindowTab:AddTabbox({ Side = 1; })
    
    local WorldInteractionsGroup = WorldGroup:AddTab("[ WORLD: 1 ]")
    do -- // World Interactions
        WorldInteractionsGroup:AddLabel("[ INTERACTIONS ]")
        WorldInteractionsGroup:AddToggle("BagPickupToggle", {
            Text = "Bag Pickup";
        })

        WorldInteractionsGroup:AddSlider("BagPickupRangeSlider", {
            Text = "Range";
            Default = 0;
            Rounding = 0;
            Min = 0;
            Max = 100;
            Compact = true;
        })

        WorldInteractionsGroup:AddDropdown("BagPickupTypeDropdown", {
            Values = {
                "Artifacts";
                "Silver";
                "Other";
            };

            Default = 1;
            Multi = true;
        })

        WorldInteractionsGroup:AddDivider()

        WorldInteractionsGroup:AddToggle("AutoPickupTrinketsToggle", {
            Text = "Auto Pickup Trinkets";
        })

        WorldInteractionsGroup:AddToggle("AutoPickupIngredientsToggle", {
            Text = "Auto Pickup Ingredients";
        })
    end

    local WorldVisualsGroup = WorldGroup:AddTab("[ WORLD: 2 ]")
    do -- // World Visuals 
        WorldVisualsGroup:AddLabel("[ VISUALS ]")
        WorldVisualsGroup:AddToggle("DisableAmbientToggle", {
            Text = "Disable Ambient";
        })

        WorldVisualsGroup:AddSlider("AmbientIntensitySlider", {
            Text = "Intensity";
            Default = 0;
            Rounding = 0;
            Min = 0;
            Max = 255;
            Compact = true;
        })

        WorldVisualsGroup:AddDivider()

        WorldVisualsGroup:AddToggle("DisableFogToggle", {
            Text = "Disable Fog";
        })

        WorldVisualsGroup:AddToggle("DisableShadowsToggle", {
            Text = "Disable Shadows";
        })
    end
    
    return WorldGroup
end

function TabGroups:ManaUtilities(WindowTab)
    local ManaUtilitiesGroup = WindowTab:AddRightGroupbox("[ MANA UTILITIES ]")

    ManaUtilitiesGroup:AddToggle("ManaChargeToggle", {
        Text = "Begin Mana Charge";
    })

    ManaUtilitiesGroup:AddSlider("ManaChargeSlider", {
        Text = "Mana %";
        Default = 0;
        Rounding = 0;
        Min = 0;
        Max = 100;
        Compact = true;
    })

    ManaUtilitiesGroup:AddDivider()

    ManaUtilitiesGroup:AddToggle("AutoSpellTrain", { Text = "Begin Spell Training"; })
    ManaUtilitiesGroup:AddToggle("AutoClimbTrainToggle", { Text = "Begin Climb Training"; })
    ManaUtilitiesGroup:AddToggle("AntiSpellBackfireToggle", { Text = "Anti Spell Backfire"; })

    ManaUtilitiesGroup:AddDivider()

    ManaUtilitiesGroup:AddLabel("[ SPELL AIMBOT ]")

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

    return ManaUtilitiesGroup
end

function Main:Init(Library, Window)
    local MainTab = Window:AddTab("[ MAIN ]")

    TabGroups:Movement(Library, MainTab);
    TabGroups:Client(Library, MainTab);
    -- TabGroups:WorldFunctions(MainTab);
    -- TabGroups:ManaUtilities(MainTab);

    return self
end

return Main
