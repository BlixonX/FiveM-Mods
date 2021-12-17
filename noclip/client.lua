noclip = false
dir = 0
multiplier = 0.01

RegisterCommand("n", function()
    ped = PlayerPedId()
    if not noclip then noclip = true
        print("Enabled Noclip")
    else noclip = false 
        print("Disabled Noclip")
    end

    coordZ = GetEntityCoords(ped)[3] - 1
    
    --[[
    while noclip do
        Wait(0)


        coords = GetEntityCoords(ped)
        SetEntityCoords(ped, coords[1], coords[2], coordZ, true, true, false, false)

        
        loop = false
        if IsControlJustPressed(1, 32) then loop = true end
        while loop do
            Wait(0)
            elevate()
            if IsControlJustReleased(1, 32) then loop = false end
            coords = GetEntityCoords(ped)
            deg = GetEntityHeading(ped)
            rem = deg%90
            print(deg)
            if deg >= 90 and deg <= 270 then y = (90 - rem) * -1 else y = 90 - rem end -- Check for Up or Down (North [+]/South [-])
            if deg >= 0 and deg <= 180 then x = rem * -1 else x = rem end              -- Check for Right or Left (East [+]/West [-])

            if (x <= 0 and y <= 0) or (x >= 0 and y >= 0) then SetEntityCoords(ped, coords[1] + (y*0.01), coords[2] + (x*0.01), coordZ, true, true, false, false) else
            SetEntityCoords(ped, coords[1] + (x*0.01), coords[2] + (y*0.01), coordZ, true, true, false, false) end


        end
    end
    ]]

    Citizen.CreateThread(function()
        while noclip do
            Citizen.Wait(0)

            coords = GetEntityCoords(ped)
            SetEntityCoords(ped, coords[1], coords[2], coordZ, true, true, false, false)
            vel = GetEntityVelocity(ped)
            SetEntityVelocity(ped, vel[1], vel[2], 0)

            loop = false
            if IsControlJustPressed(1, 32) then loop = true end
            while loop do
                Citizen.Wait(2)
                if IsControlJustReleased(1, 32) then loop = false end
                coords = GetEntityCoords(ped)
                deg = GetEntityHeading(ped)
                rem = deg%90
                if deg >= 90 and deg <= 270 then y = (90 - rem) * -1 else y = 90 - rem end -- Check for Up or Down (North [+]/South [-])
                if deg >= 0 and deg <= 180 then x = rem * -1 else x = rem end              -- Check for Right or Left (East [+]/West [-])

                if (x <= 0 and y <= 0) or (x >= 0 and y >= 0) then SetEntityCoords(ped, coords[1] + (y*multiplier), coords[2] + (x*multiplier), coordZ, true, true, false, false) else
                SetEntityCoords(ped, coords[1] + (x*multiplier), coords[2] + (y*multiplier), coordZ, true, true, false, false) end


            end
        end
    end)
    Citizen.CreateThread(function()
        while noclip do
            Citizen.Wait(0)
            up = false
            down = false
            if IsControlJustPressed(1, 22) then up = true end
            if IsDisabledControlJustPressed(1, 36) then down = true end
            while up or down do
                Citizen.Wait(5)
                if up then 
                    SetEntityCoords(ped, coords[1], coords[2], (coordZ) + multiplier, true, true, false, false)
                    coordZ = coordZ + 0.5
                end
                if down then 
                    SetEntityCoords(ped, coords[1], coords[2], (coordZ) - multiplier, true, true, false, false)
                    coordZ = coordZ - 0.5
                end
                if IsControlJustReleased(1, 22) then break end
                if IsDisabledControlJustReleased(1, 36) then break end
            end
        end
    end)

    Citizen.CreateThread(function()
        while noclip do
            Citizen.Wait(0)
            DisableControlAction(0, 36, true)
            left = false
            right = false
            if IsControlJustPressed(1, 34) then left = true end
            if IsControlJustPressed(1, 35) then right = true end
            while left or right do
                Citizen.Wait(2)

                if left then
                    SetEntityHeading(ped, GetEntityHeading(ped) + 1)
                end
                if right then
                    SetEntityHeading(ped, GetEntityHeading(ped) - 1)
                end

                if IsControlJustReleased(1, 34) then break end
                if IsControlJustReleased(1, 35) then break end
            end
        end
    end)

    Citizen.CreateThread(function()
        while noclip do
            Citizen.Wait(0)

            DisableControlAction(0, 157, true)  --1
            DisableControlAction(0, 158, true)  --2
            DisableControlAction(0, 160, true)  --3
            DisableControlAction(0, 164, true)  --4
            DisableControlAction(0, 165, true)  --5

            if IsDisabledControlJustPressed(1, 157) then multiplier = 0.005
            elseif IsDisabledControlJustPressed(1, 158) then multiplier = 0.008
            elseif IsDisabledControlJustPressed(1, 160) then multiplier = 0.01
            elseif IsDisabledControlJustPressed(1, 164) then multiplier = 0.012
            elseif IsDisabledControlJustPressed(1, 165) then multiplier = 0.02 end
        end
    end)

end, false)