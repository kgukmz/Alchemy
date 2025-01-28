local Main = {}

function Main:Load(Window)
    local MainPage = Window:Page({Name = "Main"})

    local WorldSection = MainPage:Section({
        Name = "World";
        Size = 350;
    })

    WorldSection:Toggle({
        Name = "Enable Fullbright";
        Callback = function(...)
            print("Yo:", table.unpack({...}))
        end
    })

    local ClientSection = MainPage:Section({
        Name = "Client";
        Size = 350;
    })

    ClientSection:Toggle({
        Name = ""
    })
end

return Main