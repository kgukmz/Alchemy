local Menu = {}

local Library = require("Files/Utils/Library/UILatest.lua")
local Interface = require("Files/Games/Rogue-Lineage/Interface.lua")

function Menu:Load()
    local Success, Error = pcall(Interface.Setup, Interface, Library)

    if (Success == false) then
        warn("[ALCHEMY] Error:", Error)
    end
end

return Menu