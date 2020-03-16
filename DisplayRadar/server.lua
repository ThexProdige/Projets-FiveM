RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(targetVehicle, vehicleSeat, vehicleDisplayName)
    local id = source
    Wait(0)
    TriggerClientEvent("displayRadar:on",id)

end)

RegisterNetEvent("baseevents:leftVehicle")
AddEventHandler("baseevents:leftVehicle", function(targetVehicle, vehicleSeat, vehicleDisplayName)
    local id = source
    Wait(0)
    TriggerClientEvent("displayRadar:off",id)

end)