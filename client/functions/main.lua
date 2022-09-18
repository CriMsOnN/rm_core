local appearance = {}
appearance.skin = {}
appearance.outfit = {}

function RMCore.Functions.getPlayerData()
    return RMCore.playerData
end

function RMCore.Functions.loadModel(model)
    if type(model) ~= "number" then model = GetHashKey(model) end
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end
    end
end

function RMCore.Functions.instancePlayer(instance)
    if instance then
        NetworkStartSoloTutorialSession()
    else
        NetworkEndTutorialSession()
    end
    print("Instance: " .. tostring(instance))
end

function RMCore.Functions.createCam(coords, rot, shouldRender)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    if type(coords) ~= "vector3" then coords = vector3(coords.x, coords.y, coords.z) end
    if type(rot) ~= "vector3" then rot = vector3(coords.x, coords.y, coords.z) end
    SetCamCoord(cam, coords.x, coords.y, coords.z)
    SetCamRot(cam, rot.x, rot.y, rot.z)
    SetCamActive(cam, true)
    if shouldRender then
        RenderScriptCams(true, false, 1, true, true)
    end
    return cam
end

function RMCore.Functions.getClothes(sex)
    return Clothes[sex]
end

function RMCore.Functions.getSkins(sex)
    return Skins[sex]
end

function RMCore.Functions.getFeatures()
    return Shared.features
end

function RMCore.Functions.getAppearance(appearanceType)
    if appearance[appearanceType] then return appearance[appearanceType] end
end

function RMCore.Functions.fixClothes(ped)
    local pedType = IsPedMale(ped) and "male" or "female"
    while not Natives.IsPedReadyToRender(ped) do Wait(0) end
    if pedType == "male" then
        Natives.ApplyShopItemToPed(ped, 0x158cb7f2, true, true, true)
        Natives.ApplyShopItemToPed(ped, 361562633, true, true, true)
        Natives.ApplyShopItemToPed(ped, 62321923, true, true, true)
        Natives.ApplyShopItemToPed(ped, 3550965899, true, true, true)
        Natives.ApplyShopItemToPed(ped, 612262189, true, true, true)
        Natives.ApplyShopItemToPed(ped, 319152566, true, true, true)
        Natives.ApplyShopItemToPed(ped, 0x2CD2CB71, true, true, true)
        Natives.ApplyShopItemToPed(ped, 0x151EAB71, true, true, true)
        Natives.ApplyShopItemToPed(ped, 0x1A6D27DD, true, true, true)
    else
        Natives.ApplyShopItemToPed(ped, 0x1E6FDDFB, true, true, true)
        Natives.ApplyShopItemToPed(ped, 272798698, true, true, true)
        Natives.ApplyShopItemToPed(ped, 869083847, true, true, true)
        Natives.ApplyShopItemToPed(ped, 736263364, true, true, true)
        Natives.ApplyShopItemToPed(ped, 0x193FCEC4, true, true, true)
        Natives.ApplyShopItemToPed(ped, 0x285F3566, true, true, true)
        Natives.ApplyShopItemToPed(ped, 0x134D7E03, true, true, true)
    end
end

function RMCore.Functions.defaultTorsoAndLegs(ped, value)
    local pedType = IsPedMale(ped) and "male" or "female"
    local torso = nil
    local legs = nil
    local maleTexture = nil
    local femaleTexture = nil
    if value == 1 then
        legs = Skins[pedType].bodies_lower[1]
        torso = Skins[pedType].bodies_upper[1]
        if pedType == "male" then maleTexture = GetHashKey("mp_head_mr1_sc08_c0_000_ab") end
        if pedType == "female" then femaleTexture = GetHashKey("mp_head_fr1_sc08_c0_000_ab") end
    elseif value == 2 then
        legs = Skins[pedType].bodies_lower[3]
        torso = Skins[pedType].bodies_upper[3]
        if pedType == "male" then maleTexture = GetHashKey("head_mr1_sc02_rough_c0_002_a") end
        if pedType == "female" then femaleTexture = GetHashKey("MP_head_fr1_sc03_c0_000_ab") end
    elseif value == 3 then
        legs = Skins[pedType].bodies_lower[8]
        torso = Skins[pedType].bodies_upper[8]
        if pedType == "male" then maleTexture = GetHashKey("MP_head_mr1_sc01_c0_000_ab") end
        if pedType == "female" then femaleTexture = GetHashKey("MP_head_fr1_sc01_c0_000_ab") end
    elseif value == 4 then
        legs = Skins[pedType].bodies_lower[10]
        torso = Skins[pedType].bodies_upper[10]
        if pedType == "male" then maleTexture = GetHashKey("MP_head_mr1_sc03_c0_000_ab") end
        if pedType == "female" then femaleTexture = GetHashKey("MP_head_fr1_sc03_c0_000_ab") end
    elseif value == 5 then
        legs = Skins[pedType].bodies_lower[11]
        torso = Skins[pedType].bodies_upper[11]
        if pedType == "male" then maleTexture = GetHashKey("head_mr1_sc04_rough_c0_002_ab") end
        if pedType == "female" then femaleTexture = GetHashKey("head_fr1_sc04_rough_c0_002_ab") end
    elseif value == 6 then
        legs = Skins[pedType].bodies_lower[30]
        torso = Skins[pedType].bodies_upper[30]
        if pedType == "male" then maleTexture = GetHashKey("MP_head_mr1_sc05_c0_000_ab") end
        if pedType == "female" then femaleTexture = GetHashKey("MP_head_fr1_sc05_c0_000_ab") end
    end
    Natives.ApplyShopItemToPed(ped, legs, false, true, true)
    Natives.ApplyShopItemToPed(ped, torso, false, true, true)
    Natives.ClearSomething(ped)
    if pedType == "male" then
        return maleTexture
    else
        return femaleTexture
    end
end

function RMCore.Functions.renderPed(ped, data)
    local pedType = IsPedMale(ped) and "male" or "female"
    local clothes = Clothes[pedType]
    local skins = Skins[pedType]
    local splitString = string.strsplit("_", data.name, 3)
    while not Natives.IsPedReadyToRender(ped) do Wait(0) end
    if data.type == "clothes" then
        if data.value <= 0 then
            if pedType == "male" then
                Natives.RemoveTagFromMetaPed(ped, GetHashKey(data.name), 0)
            else
                Natives.RemoveTagFromMetaPed(ped, GetHashKey(data.name), 7) -- should we use 7 for females?? i dont really know
            end
        else
            local component = clothes[data.name][data.value]
            Natives.ApplyShopItemToPed(ped, component, false, true, true)
            if appearance.outfit[data.name] and data.value <= 0 then
                appearance.outfit[data.name] = nil
            else
                appearance.outfit[data.name] = {
                    value = data.value,
                    type = data.type
                }
            end
        end
    elseif data.type == "skins" then
        if data.name == "skin" then
            local texture = RMCore.Functions.defaultTorsoAndLegs(ped, data.value)
            if pedType == "male" then texture_types.male.albedo = texture end
            if pedType == "female" then texture_types.female.albedo = texture end
        elseif splitString == "features" then
            local _, featureName = string.strsplit("_", data.name, 2)
            local hash = Shared.features[featureName]
            Natives.SetPedFaceFeature(ped, hash, data.value / 100)
        else
            local component = skins[data.name][data.value]
            Natives.ApplyShopItemToPed(ped, component, false, true, true)
        end
        if appearance.skin[data.name] and data.value <= 0 then
            appearance.skin[data.name] = nil
        else
            appearance.skin[data.name] = {
                value = data.value,
                type = data.type
            }
        end
    end

    Natives.ClearSomething(ped)
    Natives.UpdatePedVariation(ped, 0, 1, 1, 1, 0)
    Citizen.InvokeNative(0xaab86462966168ce, ped, true) -- i dont know what this is doing
    Citizen.InvokeNative(0x704c908e9c405136, ped) -- i dont know what this is doing
    Citizen.InvokeNative(0x59BD177A1A48600A, ped, 1) -- i dont know what this is doing
end
