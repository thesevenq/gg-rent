ESX = exports['es_extended']:getSharedObject()


function notifikacija(msg)
    ESX.ShowNotification(msg)
end

CreateThread(function()
    for k, v in pairs(Config.Renta) do 
        RequestModel(GetHashKey(Config.Ped))
        while not HasModelLoaded(GetHashKey(Config.Ped)) do
        Wait(1)
        end
        pedrenta = CreatePed(4, Config.Ped, v.coords, v.heading, false, true)
        FreezeEntityPosition(pedrenta, true) 
        SetEntityInvincible(pedrenta, true)
        SetBlockingOfNonTemporaryEvents(pedrenta, true)
        exports.qtarget:AddBoxZone(v.imezone, v.coords, 0.85, 0.65, {
            name=v.imezone,
            heading=0,
            debugPoly=Config.Debug,
            minZ=v.coords.z -1,
            maxZ=v.coords.z +2,
            }, {
                options = {
                    {   
                        action = function()
                        local input = lib.inputDialog("Meni rente vozila", {
                            { type = 'select', label = "Izaberite vozilo", options = {
                            { value = 'option1', label = Config.Vozila["vozilo1"].spawnkod },
                            { value = 'option2', label = Config.Vozila["vozilo2"].spawnkod },
                            { value = 'option3', label = Config.Vozila["vozilo3"].spawnkod },
                            }},
                        })
                        local opcija = input[1]
                          if opcija == 'option1' then 
                        
                            ESX.TriggerServerCallback('gg-renta:proveri_novac', function(data)
                                if data then 
                                ESX.Game.SpawnVehicle(Config.Vozila["vozilo1"].spawnkod, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vozilo1) 
                                    TaskWarpPedIntoVehicle(PlayerPedId(), vozilo1, -1)
                                 notifikacija("Uspesno ste iznajmili vozilo " ..Config.Vozila["vozilo1"].spawnkod)
                                end)
                            end
                            end, Config.Vozila["vozilo1"].cena)
                    
                            elseif opcija == 'option2' then 
                                
                            ESX.TriggerServerCallback('gg-renta:proveri_novac', function(data)
                                if data then 
                                ESX.Game.SpawnVehicle(Config.Vozila["vozilo2"].spawnkod, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vozilo2) 
                                      TaskWarpPedIntoVehicle(PlayerPedId(), vozilo2, -1)
                                   notifikacija("Uspesno ste iznajmili vozilo " ..Config.Vozila["vozilo2"].spawnkod)
                                end)
                            end
                            end, Config.Vozila["vozilo2"].cena)
                            elseif opcija == 'option3' then 
                            ESX.TriggerServerCallback('gg-renta:proveri_novac', function(data)
                                if data then 
                                ESX.Game.SpawnVehicle(Config.Vozila["vozilo3"].spawnkod, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vozilo3) 
                                      TaskWarpPedIntoVehicle(PlayerPedId(), vozilo3, -1)
                                   notifikacija("Uspesno ste iznajmili vozilo " ..Config.Vozila["vozilo3"].spawnkod)
                               end)
                            end
                            end, Config.Vozila["vozilo3"].cena)
                             end
                        end,
                        label = "Iznajmi vozilo",
                    },
                },
                distance = 4.5
        })  
        local blip = AddBlipForCoord(v.coords)

        SetBlipSprite (blip, 523)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 1)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Renta vozila')
        EndTextCommandSetBlipName(blip)
    end
end)
