shown = true
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustReleased(0, 288) then
            if shown then 
                SendNUIMessage(
                    {
                        display = true,
                    })
                shown = false
                SetNuiFocus(1, 1)
            end
        end
    end
end)

function close()
    SendNUIMessage(
    {
        display = false,
    })
    shown = true
    SetNuiFocus(0, 0)
end

RegisterNUICallback("unfocus", function()
    close()
end)

RegisterNUICallback("spawn", function(data)
    close()
    RequestModel(data.car)
    while not HasModelLoaded(data.car) do
        Wait(500)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(data.car, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)
	SetVehicleColours(vehicle, tonumber(data.colorPrime), tonumber(data.colorSecond))
    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(data.car)
end)