local OldRequire = require

local RequireCache = {}
local ServiceCache = {}

local LowThreadIdentity = false

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

if (getgenv().setthreadidentity == nil) then
    LowThreadIdentity = true
end

function RequireHook(Value)
    if (not (typeof(Value) == "string") and LowThreadIdentity ~= true) then
        return OldRequire(Value)
    end

    if (RequireCache[Value] ~= nil) then
        local CachedDirectory = RequireCache[Value]
        return CachedDirectory()
    end

    local URL = "https://github.com/kgukmz/Alchemy/raw/refs/heads/main/" .. Value
    local RequiredDirecory = loadstring(game:HttpGet(URL), "ALCHEMY")
    
    RequireCache[Value] = RequiredDirecory
    return RequiredDirecory()
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

function SafeLoad(URL)
    local Success, HttpGetResult = pcall(game.HttpGet, game, URL)

    if (Success == false) then
        warn("Unable to get thingy:", URL)
        return
    end

    local Success, Loadstring = pcall(loadstring, HttpGetResult, "ALCHEMY")

    if (Success == false) then
        warn("Unable to loadstring url:", url)
        return
    end

    return Loadstring
end

function setreadonly(Tbl, State)
    if (State == true) then
        table.freeze(Tbl)
    else
        local TblDeepclone = DeepcloneTbl(Tbl)
        return TblDeepclone
    end
end

getgenv().require = RequireHook -- // was testing something: newcclosure(RequireHook)
getgenv().GetService = GetService

if (getgenv().setreadonly == nil) then
    getgenv().setreadonly = setreadonly
end

if (getgenv().Drawing == nil) then
    getgenv().Drawing = RequireHook("Files/Utils/Modules/Drawing.lua")
end