resource = ""
RegisterCommand("rset", function(source, args) 
    resource = args[1]
end, false)

RegisterCommand("r", function(source, args)
    TriggerServerEvent("restart", resource)
    TriggerEvent('chat:addMessage', "Restarted resource: " .. resource)
end, false)