local Movement = {}

local Players = GetService("Players")
local UserInputService = GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local IsTextboxFocused = false

UserInputService.TextBoxFocused:Connect(function()
    IsTextboxFocused = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    IsTextboxFocused = false;
end)

function Movement:InfiniteJump(Value)
    if (Value == false) then
        return
    end

    repeat
        task.wait()

        local Character = LocalPlayer.Character

        if (Character == nil) then
            continue
        end

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

        if (HumanoidRootPart == nil) then
            continue
        end

        if (UserInputService:IsKeyDown(Enum.KeyCode.Space) == true and IsTextboxFocused == false) then
            local RootVelocity = HumanoidRootPart.Velocity
            local JumpVelocity = getgenv().Options.InfiniteJumpSlider.Value
            HumanoidRootPart.Velocity = Vector3.new(RootVelocity.X, JumpVelocity, RootVelocity.Z)
        end
    until getgenv().StopInfJumpPleaseBoi
end

return Movement