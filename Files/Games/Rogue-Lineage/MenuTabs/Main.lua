local Main = {}

function Main:Init(Window)
    local MainPage = Window:Page({Name = "Main"})

    local WorldSection = MainPage:Section({
        Name = "World";
        Side = "Left";
        Size = 350;
    })

    WorldSection:Toggle({
        Name = "Enable Fullbright";
        Callback = function(...)
            print("Yo:", table.unpack({...}))
        end
    })

    WorldSection:Slider({
        Name = "Intensity";
        Min = 1;
        Max = 10;
        Default = 1;
    })

    local ClientSection = MainPage:Section({
        Name = "Client";
        Side = "Right";
        Size = 350;
    })

    ClientSection:Toggle({
        Name = "Speedhack"
    })

    ClientSection:Slider({
        Name = "Speed";
        Min = 1;
        Max = 125;
        Default = 1;
    })

    ClientSection:Toggle({
        Name = "Infinite Jump"
    })

    ClientSection:Slider({
        Name = "Speed";
        Min = 1;
        Max = 125;
        Default = 1;
    })
end

return Main