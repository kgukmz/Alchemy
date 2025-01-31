local Automation = {}
local TabGroups = {}

function TabGroups:Test(WindowTab)
    local testtabbox = WindowTab:AddTabbox({ Side = 1; })

    testtabbox:AddTab("[ TEST 1 ]")
    testtabbox:AddTab("[ TEST 2 ]")
end

function Automation:Init(Window)
    local AutomationTab = Window:AddTab("[ AUTOMATION ]")

    TabGroups:Test(AutomationTab)
end

return Automation