local OldRequire = require

local RequireCache = {}
local ServiceCache = {}

local function GetService(Service)
    if (ServiceCache[Service] ~= nil) then
        return ServiceCache[Service]
    end

    local NewService = game:GetService(Service)

    if (getgenv().cloneref == nil) then
        ServiceCache[Service] = NewService
        return NewService
    end

    local Cloned = cloneref(NewService)
    ServiceCache[Service] = Cloned

    return Cloned
end

local function RequireHook(Value)
    if (not (typeof(Value) == "string") or not checkcaller()) then
        return OldRequire(Value)
    end

    if (RequireCache[Value] ~= nil) then
        local CachedDirectory = RequireCache[Value]
        return CachedDirectory()
    end

    local URL = "https://github.com/kgukmz/Alchemy/raw/refs/heads/main/" .. Value
    local RequiredDirecory = loadstring(game:HttpGet(URL), "[ALCHEMY]")
    
    RequireCache[Value] = RequiredDirecory
    return RequiredDirecory()
end

getgenv().require = newcclosure(RequireHook)
getgenv().GetService = GetService