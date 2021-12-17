RegisterNetEvent("askCoords")
RegisterNetEvent("returnCoords")

--Player ID on server  
PID = PlayerId()
SID = GetPlayerServerId(PID)
NAME = GetPlayerName(PID)


AddEventHandler('playerSpawned', function()
    PID = PlayerId()
    SID = GetPlayerServerId(PID)
    NAME = GetPlayerName(PID)
end)

RegisterCommand("tp", function(source, args)
    TriggerServerEvent("teleport", args[1], NAME)
end,false)

AddEventHandler("askCoords", function(nick)
    if NAME == nick then 
        --TriggerEvent('chat:addMessage', "4")
        TriggerServerEvent("sendCoords", GetEntityCoords(PlayerPedId()))
    end
end)

AddEventHandler("returnCoords", function(xyz, CALLER)
    if NAME == CALLER then

        SetEntityCoords(PlayerPedId(), xyz.x, xyz.y, xyz.z+0.5, false, false, false, false)
    end
end)