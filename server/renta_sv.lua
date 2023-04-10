ESX = exports['es_extended']:getSharedObject()


ESX.RegisterServerCallback("gg-renta:proveri_novac", function(source, cb, moeny)
    local igrac = ESX.GetPlayerFromId(source)
    local novac = igrac.getInventoryItem("money").count 
    if novac >= moeny then 
        cb(true)
        igrac.removeInventoryItem("money", moeny)
    else 
        cb(false)
        igrac.showNotification("Nemate dovoljno sredstava, posetite bankomat.")
    end
end)