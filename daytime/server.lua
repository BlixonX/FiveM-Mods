RegisterServerEvent("pulse")

AddEventHandler("pulse", function(hour)
    TriggerClientEvent("change", -1, hour)
    print(hour .. ":00")
end)