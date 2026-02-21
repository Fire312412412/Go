local L = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()
local W = L.CreateLib("RIVALS PRIVATE", "Midnight")
local P = game.Players.LocalPlayer
local RS = game:GetService("RunService")

local T1 = W:NewTab("Main")
local S1 = T1:NewSection("Combat & Farm")

-- Aimbot & Wallbang
local aim = false
S1:NewToggle("에임 핵 (벽뚫)", "자동 조준 및 벽 관통", function(t)
    aim = t
    RS.RenderStepped:Connect(function()
        if aim then
            local target = nil
            local dist = 1000
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= P and v.Character and v.Character:FindFirstChild("Head") then
                    local m = (v.Character.Head.Position - P.Character.Head.Position).Magnitude
                    if m < dist then dist = m target = v end
                end
            end
            if target then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
            end
        end
    end)
end)

-- Auto Item Farm (Health/Ammo)
local farm = false
S1:NewToggle("아이템 오토팜", "체력/총알 자동 획득", function(t)
    farm = t
    spawn(function()
        while farm do
            task.wait()
            for _, v in pairs(workspace:GetChildren()) do
                if (v.Name:find("Health") or v.Name:find("Ammo")) and v:IsA("BasePart") then
                    if (v.Position - P.Character.HumanoidRootPart.Position).Magnitude < 100 then
                        P.Character.HumanoidRootPart.CFrame = v.CFrame
                    end
                end
            end
        end
    end)
end)

local T2 = W:NewTab("Stealth")
local S2 = T2:NewSection("Defense")

-- Anti-Aim & Invisibility
local stealth = false
S2:NewToggle("안티 에임/은신", "적의 조준 방해 및 투명화", function(t)
    stealth = t
    RS.Stepped:Connect(function()
        if stealth and P.Character then
            for _, v in pairs(P.Character:GetDescendants()) do
                if v.Name == "HumanoidRootPart" then v.Velocity = Vector3.new(0, 500, 0) end
                if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 v.CanCollide = false end
            end
        end
    end)
end)

-- Visual Skin Unlock
S2:NewButton("올스킨 (본인 전용)", "모든 스킨 활성화", function()
    for _, v in pairs(P:FindFirstChild("Skins") or {}) do v.Value = true end
end)

-- Misc
local S3 = T2:NewSection("Misc")
S3:NewSlider("Speed", "이동 속도", 500, 16, function(v) P.Character.Humanoid.WalkSpeed = v end)
S3:NewButton("God Mode", "무적", function() P.Character.Humanoid.MaxHealth = 1e15 P.Character.Humanoid.Health = 1e15 end)
