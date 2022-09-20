RMCore = {}
RMCore.Functions = {}

-- local loadModel = load_module('utils/loadModel')

local staticCamera = nil
local utils = require 'utils/{loadModel,createCam,instancePlayer}'
local clothes = require 'preload/{fixClothes,renderPed}'

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
    local ped = PlayerPedId()
    DisplayRadar(false)
    DisplayHud(false)
    DoScreenFadeOut(0)
    SetFocusPosAndVel(Config.characterSelection.spawn.x, Config.characterSelection.spawn.y,
        Config.characterSelection.spawn.z, 0.0, 0.0, 0.0)
    SetEntityCoords(ped, Config.characterSelection.pedSpawn.x, Config.characterSelection.pedSpawn.y,
        Config.characterSelection.pedSpawn.z)
    SetEntityHeading(ped, Config.characterSelection.pedSpawn.w)
    utils.instancePlayer(true)
    NetworkClockTimeOverride(12, 0, 0)
    local model = characters[1].sex == "male" and GetHashKey("mp_male") or GetHashKey("mp_female")
    utils.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    clothes:fixClothes(ped)
    local initialCamera = utils.createCam(Config.characterSelection.initialCamera.coords,
        Config.characterSelection.initialCamera.rot, true)
    staticCamera = utils.createCam(Config.characterSelection.staticCamera.coords,
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
    utils.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    local ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(ped, 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(ped, 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(ped, 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    clothes:fixClothes(ped)
    local pCoordsOffset = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0)
    local creatorCamera = utils.createCam(pCoordsOffset, vector3(0.0, 0.0, 0.0))
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
    utils.loadModel(model)
    SetPlayerModel(PlayerId(), model, false)
    ped = PlayerPedId()
    Natives.EquipMetaPedOutfitPreset(ped, 0, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x1D4C528A, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0x3F1F01E5, 0)
    Natives.RemoveTagFromMetaPed(PlayerPedId(), 0xDA0E2C55, 0)
    SetModelAsNoLongerNeeded(model)
    clothes:fixClothes(ped)
    playerData.skin = type(playerData.skin) == "string" and json.decode(playerData.skin) or playerData.skin
    playerData.outfit.components = type(playerData.outfit.components) == "string" and
        json.decode(playerData.outfit.components) or playerData.outfit.components
    for k, v in pairs(playerData.skin) do
        v.name = k
        clothes:renderPed(ped, v)
    end

    for k, v in pairs(playerData.outfit.components) do
        v.name = k
        clothes:renderPed(ped, v)
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
