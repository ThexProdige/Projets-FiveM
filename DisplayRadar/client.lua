
RegisterNetEvent('displayRadar:on')
AddEventHandler('displayRadar:on', function()
    DisplayRadar(true)
end)
RegisterNetEvent('displayRadar:off')
AddEventHandler('displayRadar:off', function()
    DisplayRadar(false)
end)
