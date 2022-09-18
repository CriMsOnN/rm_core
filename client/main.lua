RMCore = {}
RMCore.Functions = {}
local staticCamera = nil
Clothes = {
    male = {},
    female = {}
}

Skins = {
    male = {},
    female = {}
}

function insert(tbl, value)
    tbl[#tbl + 1] = value
end

CreateThread(function()
    for _, v in pairs(pedClothes.female) do
        if v.category_hashname == "heads" or v.category_hashname == "eyes" or v.category_hashname == "bodies_upper" or
            v.category_hashname == "bodies_lower" or
            v.category_hashname == "hair" then
            if Skins.female[v.category_hashname] == nil then Skins.female[v.category_hashname] = {} end
            local category = Skins.female[v.category_hashname]
            insert(category, v.hash)
        else
            if Clothes.female[v.category_hashname] == nil then Clothes.female[v.category_hashname] = {} end
            local category = Clothes.female[v.category_hashname]
            insert(category, v.hash)
        end
    end

    for _, v in pairs(pedClothes.male) do
        if v.category_hashname == "heads" or v.category_hashname == "eyes" or v.category_hashname == "bodies_upper" or
            v.category_hashname == "bodies_lower" or v.category_hashname == "beards_complete" or
            v.category_hashname == "hair" then
            if Skins.male[v.category_hashname] == nil then Skins.male[v.category_hashname] = {} end
            local category = Skins.male[v.category_hashname]
            insert(category, v.hash)
        else
            if Clothes.male[v.category_hashname] == nil then Clothes.male[v.category_hashname] = {} end
            local category = Clothes.male[v.category_hashname]
            insert(category, v.hash)
        end
    end
end)

SetTimeout(500, function()
    Natives.DisplayLoadingScreens(0, 0, 0, "You are loading please wait", "", "")
    exports.spawnmanager:spawnPlayer({
        x = Config.characterSelectionSpawn.x,
        y = Config.characterSelectionSpawn.y,
        z = Config.characterSelectionSpawn.z,
        heading = math.random(-90.0, 90.0),
        model = GetHashKey("mp_male"),
        skipFade = true
    })
    exports.spawnmanager:setAutoSpawn(false)
    TriggerServerEvent("rm:playerSpawned")
end)


RegisterNetEvent("rm:playerSpawned", function(characters)
    RMCore.isLoading = true
    Wait(10000)
    local ped = PlayerPedId()
    DisplayRadar(false)
    DisplayHud(false)
    DoScreenFadeOut(0)
    SetFocusPosAndVel(Config.characterSelection.spawn.x, Config.characterSelection.spawn.y,
        Config.characterSelection.spawn.z, 0.0, 0.0, 0.0)
    SetEntityCoords(ped, Config.characterSelection.pedSpawn.x, Config.characterSelection.pedSpawn.y,
        Config.characterSelection.pedSpawn.z)
    SetEntityHeading(ped, Config.characterSelection.pedSpawn.w)
    RMCore.Functions.instancePlayer(true)
    NetworkClockTimeOverride(12, 0, 0)
    local model = characters[1].sex == "male" and GetHashKey("mp_male") or GetHashKey("mp_female")
    RMCore.Functions.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    RMCore.Functions.fixClothes(ped)
    local initialCamera = RMCore.Functions.createCam(Config.characterSelection.initialCamera.coords,
        Config.characterSelection.initialCamera.rot, true)
    staticCamera = RMCore.Functions.createCam(Config.characterSelection.staticCamera.coords,
        Config.characterSelection.staticCamera.rot)
    ShutdownLoadingScreen()
    Wait(2000)
    while GetIsLoadingScreenActive() do
        ShutdownLoadingScreen()
        Wait(0)
    end
    SetCamActiveWithInterp(staticCamera, initialCamera, Config.characterSelection.cameraInterp, 10.0, 10.0)
    DoScreenFadeIn(1000)
    Wait(Config.characterSelection.cameraInterp)

    print(json.encode(characters, { indent = true }))
    SendNUIMessage({
        action = "setCharacters",
        data = {
            characters = characters
        }
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('createCharacter', function(data, cb)
    SetNuiFocus(false, false)
    cb(true)
    local model = data.sex == "male" and GetHashKey("mp_male") or GetHashKey("mp_female")
    RMCore.Functions.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    local ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(ped, 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(ped, 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(ped, 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    RMCore.Functions.fixClothes(ped)
    local pCoordsOffset = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0)
    local creatorCamera = RMCore.Functions.createCam(pCoordsOffset, vector3(0.0, 0.0, 0.0))
    SetCamActiveWithInterp(creatorCamera, staticCamera, Config.characterSelection.cameraInterp, 10.0, 10.0)
    Wait(Config.characterSelection.cameraInterp)
    exports.rm_clothing:openClothingMenu({
        clothes = true,
        skins = true
    }, data, creatorCamera)
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    DoScreenFadeOut(10)
    SetNuiFocus(false, false)
    TriggerServerEvent('rm:playerLogin', data.charid)
    cb(true)
end)

RegisterNetEvent("rm:playerLogin", function(playerData)
    ClearFocus()
    local model = playerData.sex == "male" and GetHashKey("mp_male") or GetHashKey("mp_female")
    RMCore.Functions.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    RMCore.Functions.fixClothes(ped)
    for k, v in pairs(playerData.skin) do
        v.name = k
        RMCore.Functions.renderPed(ped, v)
    end

    for k, v in pairs(playerData.outfit.components) do
        v.name = k
        RMCore.Functions.renderPed(ped, v)
    end

    RMCore.isLoading = false
    RMCore.playerData = playerData
    DestroyAllCams(true)
    SetEntityCoords(PlayerPedId(), playerData.coords.x, playerData.coords.y, playerData.coords.z)
    StartPlayerTeleport(PlayerId(), playerData.coords.x, playerData.coords.y, playerData.coords.z,
        math.random(-90.0, 90.0),
        false, false, false)
    while IsPlayerTeleportActive() do Wait(0) end
    DoScreenFadeIn(1000)
    while IsScreenFadingIn() do Wait(0) end
    Wait(1000)
end)


exports('getCore', function()
    return RMCore
end)

AddEventHandler("onResourceStop", function()
    DestroyAllCams(true)
end)
