local player = PlayerPedId()
local rotation = GetEntityHeading(player)
local pos = vector3(0, 0, 0)
RegisterCommand("setpoint", function()
    player = PlayerPedId()
    rotation = GetEntityHeading(player)
    pos = GetEntityCoords(player)
    TriggerEvent('chat:addMessage', "Teleport saved!")
    --SetPedCoordsKeepVehicle( player, pos.x, pos.y, pos.z )
end,false)

RegisterCommand("goto", function()
    player = PlayerPedId()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        TriggerEvent('chat:addMessage', "No teleport saved!")
    else
        SetPedCoordsKeepVehicle( player, pos.x, pos.y, pos.z+1, rotation )
        TriggerEvent('chat:addMessage', "Teleported")
    end
end,false)