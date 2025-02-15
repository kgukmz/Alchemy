local Main = {}
local Sections = {}

local Removals = require("Files/Games/Rogue-Lineage/Features/Removals.lua")
local Movement = require("Files/Games/Rogue-Lineage/Features/Movement.lua")
local Utility = require("Files/Games/Rogue-Lineage/Features/Utility.lua")

function CheckEnv(Global, Callback)
    if (getgenv == nil) then
        return
    end

    warn(getgenv()[Global])

    if (getgenv()[Global] == nil) then
        return
    end

    coroutine.wrap(Callback)()
end

function Sections:Movement(WindowTab, Library)
    local MovementSection = WindowTab:Section({
        Name = "Movement";
        AutoSize = true;
        Side = "Left";
    })
    
    MovementSection:Toggle({
        Name = "Fly";
        Pointer = "FlyToggle";
    })

    MovementSection:Toggle({
        Name = "Speedhack";
        Pointer = "SpeedhackToggle";
    })

    MovementSection:Toggle({
        Name = "Infinite Jump";
        Callback = Movement.InfiniteJump;
        Pointer = "InfiniteJumpToggle";
    })

    MovementSection:Slider({
        Name = "Fly";
        Min = 0;
        Max = 125;
        State = 0;
        Pointer = "FlySlider";
    })

    MovementSection:Slider({
        Name = "Speedhack";
        Min = 0;
        Max = 125;
        State = 0;
        Pointer = "SpeedhackSilder";
    })

    MovementSection:Slider({
        Name = "Infinite Jump";
        Min = 0;
        Max = 125;
        State = 0;
        Pointer = "InfiniteJumpSlider";
    })

    return MovementSection
end

function Sections:Client(WindowTab, Library)
    local ClientSection = WindowTab:Section({
        Name = "Client";
        AutoSize = true;
        Side = "Right";
    })

    ClientSection:Toggle({
        Name = "Disable Fall Damage";
        Callback = Removals.DisableFallDamage;
        Pointer = "DisableFallDamageToggle";
    })

    ClientSection:Toggle({
        Name = "Disable Kill Bricks";
        Callback = Removals.DisableKillBricks;
        Pointer = "DisableKillBricksToggle";
    })

    ClientSection:Toggle({
        Name = "Disable Poison Pits";
        Callback = Removals.DisablePoisonPits;
        Pointer = "DisablePoisonToggle";
    })
    
    ClientSection:Toggle({
        Name = "Remove Orderly Fields";
        Callback = Removals.RemoveOrderFields;
        Pointer = "RemoveFieldsToggle";
    })

    CheckEnv("getconnections", function()
        ClientSection:Toggle({
            Name = "Enable Anti-AFK";
            Callback = Removals.AntiAFk;
            Pointer = "AntiAfkToggle";
        })
    end)

    ClientSection:Button({
        Name = "Suicide";
        Callback = function()
            Library:Notification("Test 123 | Milo", 5)
        end
    })

    ClientSection:Button({
        Name = "Reset";
        Callback = Utility.CharacterReset;
    })

    return ClientSection
end

function Sections:Utility(WindowTab, Library)
    local UtilitySection = WindowTab:Section({
        Name = "Utility";
        AutoSize = true;
        Side = "Right";
    })

    UtilitySection:List({
        Name = "Teleport Locations";
        Options = {
            "Alana";
            "Oresfall";
            "Castle Sanctuary";
            "Flowerlight";
        }
    })

    UtilitySection:Button({
        Name = "Teleport";
        --// Risk = true;
    })

    UtilitySection:Textbox({
        Name = "Job-ID";
        Placeholder = "Enter a Job-ID...";
    })

    UtilitySection:Button({
        Name = "Join Job-ID";
    })

    UtilitySection:Toggle({
        Name = "Region Check";
        Pointer = "RegionCheckToggle";
    })

    UtilitySection:List({
        Name = "Region Filter";
        Options = {
            "Hesse, Germany";
            "England, United Kingdom";
            "California, United States";
            "Washington, United States";
            "North Holland, The Netherlands";
            "Florida, United States";
            "New South Wales, Australia";
            "Tokyo, Japan";
            "Unknown Region";
        };
        Default = "Unknown Region";
        Pointer = "ServerRegionList";
    })

    UtilitySection:List({
        Name = "Server Hop Filter";
        Options = {
            "Smallest";
            "Largest";
            "Any";
        };
        Default = "Any";
        Pointer = "ServerFilterList";
    })

    UtilitySection:Button({
        Name = "Server Hop";
        Callback = function()
            local Data = {
                Filter = Library.Flags.ServerFilterList
            }

            if (Library.Flags.RegionCheckToggle == true) then
                Data.Region = Library.Flags.ServerRegionList
            end

            Utility:ServerHop(Data)
        end;
    })

    return UtilitySection
end

function Main:Initialize(Window, Library)
    local MainPage = Window:Page({ Name = "Main"} )

    Sections:Movement(MainPage, Library)
    Sections:Client(MainPage, Library)
    Sections:Utility(MainPage, Library)
end

return Main