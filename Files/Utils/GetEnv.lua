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
    if (not (typeof(Value) == "string")) then
        local Module = OldRequire(Value)
        return Module
    end

    if (RequireCache[Value] ~= nil) then
        local CachedDirectory = RequireCache[Value]
        return CachedDirectory()
    end

    local RequiredDirecory = loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/" .. Value))
    RequireCache[Value] = RequiredDirecory

    return RequiredDirecory()
end

getgenv().require = RequireHook
getgenv().GetService = GetService