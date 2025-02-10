local OldRequire = require

local RequireCache = {}
local ServiceCache = {}

local function DeepcloneTbl(Target)
    local Result = {}

    for i, v in pairs(Target) do
        if (typeof(v) == "table") then
            Result[i] = DeepcloneTbl(Target)
        end

        Result[i] = v
    end

    return Result
end

function GetService(Service)
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

function setreadonly(Tbl, State)
    if (State == true) then
        table.freeze(Tbl)
    else
        local TblDeepclone = DeepcloneTbl(Tbl)
        return TblDeepclone
    end
end

function RequireHook(Value)
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

getgenv().require = RequireHook -- // was testing something: newcclosure(RequireHook)
getgenv().GetService = GetService

if (getgenv().setreadonly == nil) then
    getgenv().setreadonly = setreadonly
end