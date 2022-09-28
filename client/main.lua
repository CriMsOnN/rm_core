RMCore = {
    isLoading = false,
    isLoggedIn = false,
    playerData = {},
    Functions = {}
}

RMCore.Functions = setmetatable({}, {
    __newindex = function(self, key, value)
        exports(key, value)
    end
})


local staticCamera = nil

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
    TriggerServerEvent("queue:dequeuePlayer")
end)


RegisterNetEvent("rm:playerSpawned", function(characters)
    RMCore.isLoading = true
    Wait(10000)
    local ped = cache.ped
    cache.characters = characters
    DisplayHud(false)
    DisplayRadar(false)
    Natives.ShowPlayerCores(false)
    SetMinimapType(3)
    DoScreenFadeOut(0)
    SetFocusPosAndVel(Config.characterSelection.spawn.x, Config.characterSelection.spawn.y,
        Config.characterSelection.spawn.z, 0.0, 0.0, 0.0)
    SetEntityCoords(ped, Config.characterSelection.pedSpawn.x, Config.characterSelection.pedSpawn.y,
        Config.characterSelection.pedSpawn.z)
    SetEntityHeading(ped, Config.characterSelection.pedSpawn.w)
    lib.instancePlayer(true)
    NetworkClockTimeOverride(12, 0, 0)
    local model = characters[1].sex == "male" and GetHashKey("mp_male") or GetHashKey("mp_female")
    lib.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    cache:set("ped", PlayerPedId())
    ped = cache.ped
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    lib.fixClothes(ped)
    local initialCamera = lib.createCam(Config.characterSelection.initialCamera.coords,
        Config.characterSelection.initialCamera.rot, true)
    staticCamera = lib.createCam(Config.characterSelection.staticCamera.coords,
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
    lib.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    local ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(ped, 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(ped, 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(ped, 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    lib.fixClothes(ped)
    local pCoordsOffset = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0)
    local creatorCamera = lib.createCam(pCoordsOffset, vector3(0.0, 0.0, 0.0))
    SetCamActiveWithInterp(creatorCamera, staticCamera, Config.characterSelection.cameraInterp, 10.0, 10.0)
    Wait(Config.characterSelection.cameraInterp)
    exports.rm_clothing:openClothingMenu({
        clothes = true,
        skins = true
    }, data, creatorCamera)
end)

RegisterNUICallback("previewCharacter", function(data, cb)
    cb(true)
    local charid = data.charid
    local characters = cache.characters
    local char = {}
    for i = 1, #characters do
        local character = characters[i]
        if character.charid == charid then
            char = character
            break
        end
    end
    local model = char.sex == "male" and GetHashKey("mp_male") or GetHashKey("mp_female")
    lib.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    cache.ped = PlayerPedId()
    SetEntityAlpha(cache.ped, 0)
    Natives.EquipMetaPedOutfitPreset(cache.ped, 0, 0)
    Natives.RemoveTagFromMetaPed(cache.ped, 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(cache.ped, 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(cache.ped, 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    lib.fixClothes(cache.ped)
    if char.skin then
        for k, v in pairs(char.skin) do
            v.name = k
            lib.renderPed(cache.ped, v)
        end
    end

    if char.outfit then
        for k, v in pairs(char.outfit) do
            v.name = k
            lib.renderPed(cache.ped, v)
        end
    end
    SetEntityAlpha(cache.ped, 255)

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
    lib.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    lib.fixClothes(ped)
    playerData.skin = type(playerData.skin) == "string" and json.decode(playerData.skin) or playerData.skin
    playerData.outfit.components = type(playerData.outfit.components) == "string" and
        json.decode(playerData.outfit.components) or playerData.outfit.components
    for k, v in pairs(playerData.skin) do
        v.name = k
        lib.renderPed(ped, v)
    end

    for k, v in pairs(playerData.outfit.components) do
        v.name = k
        lib.renderPed(ped, v)
    end

    RMCore.isLoading = false
    RMCore.playerData = playerData
    DestroyAllCams(true)
    StartPlayerTeleport(PlayerId(), playerData.coords.x, playerData.coords.y, playerData.coords.z,
        math.random(-90.0, 90.0),
        false, false, false)
    while IsPlayerTeleportActive() do Wait(0) end
    DoScreenFadeIn(1000)
    while IsScreenFadingIn() do Wait(0) end
    Wait(1000)
    DisplayHud(true)
    DisplayRadar(true)
    Natives.ShowPlayerCores(true)
    SetMinimapType(3)
    RMCore.isLoggedIn = true
    startCoordsUpdate()
end)

RegisterNetEvent("rm:playerLoggout", function()
    Natives.DisplayLoadingScreens(0, 0, 0, "You are loading please wait", "", "")
    RMCore.playerData = {}
    TriggerServerEvent("rm:playerSpawned")
end)

function startCoordsUpdate()
    while isLoggedIn do
        Wait(60000)
        TriggerServerEvent("rm:updateCoords", GetEntityCoords(cache.ped))
    end
end

CreateThread(function()
    while true do
        Natives.DisableHudContext(GetHashKey("HUD_CTX_IN_FAST_TRAVEL_MENU"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_DEADEYE"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_DEADEYE_CORE"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_HEALTH"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_HEALTH_CORE"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_HORSE_HEALTH"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_HORSE_HEALTH_CORE"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_HORSE_STAMINA"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_HORSE_STAMINA_CORE"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_STAMINA"))
        Natives.DisableHudContext(GetHashKey("HUD_CTX_ITEM_CONSUMPTION_STAMINA_CORE"))
        DisableControlAction(0, 0x580C4473, true)
        DisableControlAction(0, 0xCF8A4ECA, true)
        DisableControlAction(0, 0x9CC7A1A4, true)
        DisableControlAction(0, 0x1F6D95E5, true)
        Wait(500)
    end
end)


exports('getCore', function()
    return RMCore
end)

AddEventHandler("onResourceStop", function(source)
    if GetCurrentResourceName() == resource then
        DestroyAllCams(true)
    end
end)
