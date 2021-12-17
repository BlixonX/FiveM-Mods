AddEventHandler('onClientResourceStart', function(friendfire)
    if (GetCurrentResourceName() ~= friendfire) then
      return
    end
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(-1, true, true) 
end)