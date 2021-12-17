RegisterServerEvent("restart")

AddEventHandler("restart", function(res)
    StopResource(res)
    StartResource(res)
    print("Restarted resource: " .. res)
end)