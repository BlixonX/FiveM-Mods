local isGod = false
local player
function goddify(player)
    while isGod do
        Wait(10)
        if GetEntityHealth(player) < 100000 then
            SetEntityHealth(player, 100000)
        end
    end
end

RegisterCommand("god", function()
    player = PlayerPedId()
    if not isGod then
        isGod = true
        SetPedMaxHealth(player, 100000)
        TriggerEvent('chat:addMessage', "Godmode enabled")
    else
        isGod = false
        SetPedMaxHealth(player, 200)
        SetEntityHealth(player, 200)
        TriggerEvent('chat:addMessage', "Godmode disabled")
    end
    --TriggerEvent('chat:addMessage', tostring(GetPedMaxHealth(player)) )
    
    goddify(player)
end, false)

RegisterCommand("kill", function()
    if isGod then
        isGod = false
        SetEntityHealth(PlayerPedId(), 0)
        Wait(3500)
        ExecuteCommand("god")
    else 
        SetEntityHealth(PlayerPedId(), 0)
    end
end, false)
