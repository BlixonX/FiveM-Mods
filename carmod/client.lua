--[[


SetVehicleMod(
	vehicle  Vehicle , 
	modType  integer , 
	modIndex  integer , 
	customTires  boolean 
)


]]


RegisterCommand("mod", function(source, args)
    veh = GetVehiclePedIsUsing(PlayerPedId())
    if args[1] == "17" or args[1] == "18" or args[1] == "19" or args[1] == "20" or args[1] == "21" or args[1] == "22" then
        if args[2] == "off" then
            ToggleVehicleMod(veh, tonumber(args[1]), false)
            TriggerEvent('chat:addMessage', args[1] .. ": off")
        else
            ToggleVehicleMod(veh, tonumber(args[1]), true)
            TriggerEvent('chat:addMessage', args[1] .. ": on")
        end
    else
        SetVehicleModKit(veh, 0)
        SetVehicleMod(veh, tonumber(args[1]), tonumber(args[2]), false)
        TriggerEvent('chat:addMessage', args[1] .. ": " .. tostring( GetVehicleMod(veh, tonumber(args[1])) ) )
    end
end, false)

RegisterCommand("fix", function(source, args)
    veh = GetVehiclePedIsUsing(PlayerPedId())
    SetVehicleEngineHealth(veh, 1000)
    SetVehicleFixed(veh)
end, false)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisableControlAction(0, 289, true)
        if IsDisabledControlJustPressed(0, 289, true) and GetVehiclePedIsUsing(PlayerPedId()) ~= 0 then
            vehicle = GetVehiclePedIsUsing(PlayerPedId())
            currentmods = {}
            for i=0, 25 do
                table.insert(currentmods, GetVehicleMod(vehicle, i))
            end

            SetVehicleModKit(vehicle, 0)
            
            mods = {}

            SetNuiFocus(1, 1)
            for type=0, 25 do
                for index=0, 100 do
                    SetVehicleMod(vehicle, type, index, false)
                    if GetVehicleMod(vehicle, type) == -1 then
                        table.insert(mods, index-1)
                        break
                    end
                end
            end
            mods[18] = 0
            mods[19] = 0
            mods[20] = 0
            mods[21] = 0
            mods[22] = 0
            mods[23] = 0

            for i=0, 25 do
                SetVehicleMod(vehicle, i, currentmods[i+1], false)
            end
            SendNUIMessage(
                {
                    mods = mods,
                    currentmods = currentmods
                }
            )
        end
    end
end)


RegisterNUICallback("hide", function()
    SetNuiFocus(0, 0)
end)

RegisterNUICallback("changeMod", function(data)
    vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if data.type == 17 or data.type == 18 or data.type == 19 or data.type == 20 or data.type == 21 or data.type == 22 then
        if data.index == 0 then
            ToggleVehicleMod(vehicle, data.type, true)
        else
            ToggleVehicleMod(vehicle, data.type, false)
        end
    else
        SetVehicleMod(vehicle, data.type, data.index, false)
    end
end)