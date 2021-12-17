RegisterNetEvent("change")

AddEventHandler("change", function(hour)
    NetworkOverrideClockTime(hour, 0, 0)
end)

RegisterCommand("day", function(source, args)
    TriggerServerEvent("pulse", tonumber(args[1]))
    --NetworkOverrideClockTime(tonumber(args[1]), 0, 0)
end, false)