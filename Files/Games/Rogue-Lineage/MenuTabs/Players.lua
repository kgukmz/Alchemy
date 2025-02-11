local Players = {}
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


function Players:Initialize(Window)
    local MainPage = Window:Page({ Name = "Players"})
    MainPage:PlayerList()
end

return Players