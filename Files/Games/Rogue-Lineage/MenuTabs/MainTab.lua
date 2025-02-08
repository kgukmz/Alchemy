local Main = {}
local Sections = {}

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

function Sections:Movement(WindowTab)
    local MovementSection = WindowTab:Section({
        Name = "Movement";
        AutoSize = true;
    })
    
    MovementSection:Toggle({
        Name = "Fly";
    })

    MovementSection:Toggle({
        Name = "Speedhack";
    })

    MovementSection:Toggle({
        Name = "Infinite Jump";
    })

    MovementSection:Slider({
        Name = "Fly";
        Min = 0;
        Max = 125;
        State = 0;
    })

    MovementSection:Slider({
        Name = "Speedhack";
        Min = 0;
        Max = 125;
        State = 0;
    })

    MovementSection:Slider({
        Name = "Infinite Jump";
        Min = 0;
        Max = 125;
        State = 0;
    })

    return MovementSection
end

function Sections:Client(WindowTab)
    local RemovalSection = WindowTab:Section({
        Name = "Client";
        AutoSize = true;
    })
    
    CheckEnv("hookfunction", function()
        RemovalSection:Toggle({
            Name = "Disable Fall Damage";
        })
    end)

    CheckEnv("bootyfucker", function()
        RemovalSection:Toggle({
            Name = "Disable Fall Damage";
        })
    end)

    local YhSection = WindowTab:Section({
        Name = "Yh";
        AutoSize = true;
    })

    local Sections = {}
    table.insert(Sections, RemovalSection)
    table.insert(Sections. YhSection)

    local MultiSection = WindowTab:MultiSection({
        Sections = Sections
    })

    return MultiSection
end

function Main:Initialize(Window)
    local MainPage = Window:Page({ Name = "Main"} )

    Sections:Movement(MainPage)
    Sections:Client(MainPage)
end

return Main