local OldRequire = require

local RequireCache = {}
local ServiceCache = {}

local function GetService(Service)
    if (ServiceCache[Service] ~= nil) then
        return ServiceCache[Service]
    end

    if (getgenv().cloneref == nil) then
        warn("cloneref not supported, assigning a replacement...")
        
        getgenv().cloneref = function(...)
            return ...
        end
    end

    local NewService = cloneref(game:GetService(Service))
    ServiceCache[Service] = NewService

    return NewService
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