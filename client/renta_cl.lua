ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    for k, v in pairs(Config.Renta) do 
        local rentPed = napraviPeda(v)
        exports.qtarget:AddTargetEntity(rentPed, {
            options = {
                {
                    icon = "fas fa-car",
                    label = 'Iznajmi Vozilo',
                    action = function()
                        otvoriRentu()
                    end,
                },
            },
            distance = 3.0
        })

        napraviBlip(v)
    end
end)

function otvoriRentu()
    local opcije = {}

    for k,v in pairs(Config.RentVozila) do
        table.insert(opcije, {
            value = json.encode(v), 
            label = v.label
        })
    end

    local input = lib.inputDialog("Meni rente vozila", {
        { type = 'select', label = "Izaberite vozilo", options = opcije}
    })

    local odabranaOpcija = input[1]
    local podaciVozila = json.decode(odabranaOpcija)

    ESX.TriggerServerCallback('gg-renta:proveri_novac', function(imaDovoljno)
        if imaDovoljno then 
            ESX.Game.SpawnVehicle(podaciVozila.spawnKod, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vozilo) 
                TaskWarpPedIntoVehicle(PlayerPedId(), vozilo, -1)
                ESX.ShowNotification("Uspesno ste iznajmili vozilo " .. podaciVozila.label)
            end)
        end
    end, podaciVozila.cena)
end

function napraviPeda(renta)
    RequestModel(GetHashKey(Config.Ped))
    while not HasModelLoaded(GetHashKey(Config.Ped)) do
        Wait(1)
    end

    pedrenta = CreatePed(4, Config.Ped, renta.coords, renta.heading, false, true)
    FreezeEntityPosition(pedrenta, true) 
    SetEntityInvincible(pedrenta, true)
    SetBlockingOfNonTemporaryEvents(pedrenta, true)

    return pedrenta
end

function napraviBlip(renta)
    local blip = AddBlipForCoord(renta.coords)

    SetBlipSprite (blip, 523)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Renta Vozila')
    EndTextCommandSetBlipName(blip)
end