Natives = {
    DisplayLoadingScreens = function(p0, p1, p2, p3, p4, p5)
        Citizen.InvokeNative(0x1E5B70E53DB661E5, p0, p1, p2, p3, p4, p5)
    end,
    IsPedReadyToRender = function(ped)
        return Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
    end,
    EquipMetaPedOutfitPreset = function(ped, presetId, p2)
        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, presetId, p2)
    end,
    ResetPedComponents = function(ped)
        Citizen.InvokeNative(0x0BFA1BD465CDFEFD, ped)
    end,
    ApplyShopItemToPed = function(ped, componentHash, immediately, isMp, p4)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, mp4)
    end,
    RemoveTagFromMetaPed = function(ped, component, p2)
        Citizen.InvokeNative(0xD710A5007C2AC539, ped, component, p2)
    end,
    ClearSomething = function(ped)
        Citizen.InvokeNative(0x704C908E9C405136, ped)
    end,
    UpdatePedVariation = function(ped, p1, p2, p3, p4, p5)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, p1, p2, p3, p4, p5)
    end,
    GetNumComponentsInPed = function(ped)
        return Citizen.InvokeNative(0x90403E8107B60E81, ped)
    end,
    GetMetaPedType = function(ped)
        return Citizen.InvokeNative(0xEC9A1261BF0CE510, ped)
    end,
    GetShopPedComponentAtIndex = function(ped, index, bool, struct1, struct2)
        return Citizen.InvokeNative(0x77BA37622E22023B, ped, index, bool, struct1, struct2)
    end,
    GetShopPedComponentCategory = function(componentHash, metaPedType, bool)
        return Citizen.InvokeNative(0x5FF9A878C3D115B8, componentHash, metaPedType, bool)
    end,
    SetPedFaceFeature = function(ped, index, value)
        Citizen.InvokeNative(0x5653AB26C82938CF, ped, index, value)
    end
}
