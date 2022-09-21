Client = {
    playerData = {},
    job = {},
    previousJob = {},
    currency = {},
    inventory = {},
    coords = {},
    outfit = {},
    sex = {},
    skin = {},
    firstname = {},
    lastname = {}
}

RegisterNetEvent("rm:playerLogin", function(playerData)
    Client.playerData = playerData
end)

RegisterNetEvent("rm:setPlayerData", function(playerData)
    Client.playerData = playerData
end)

RegisterNetEvent("rm:setJob", function(oldJob, newJob)
    Client.playerData.job = newJob
    Client.playerData.previousJob = oldJob
end)

RegisterNetEvent("rm:setCurrency", function(cType, cAmount)
    if Client.playerData.currency[cType] then
        Client.playerData.currency[cType] = cAmount
    end
end)

RegisterNetEvent("rm:setInventory", function(inventory)
    Client.playerData.inventory = inventory
end)
