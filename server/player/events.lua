local PlayerDB <const> = require 'player/player.db'
local Player <const> = require 'player/player'


RegisterServerEvent("rm:playerSpawned", function()
    local _src = source
    local player = Player.getInstance(_src)
    if not player then
        local identifiers = lib.getIdentifiers(_src)
        player = Player.init(_src, identifiers[Config.defaultIdentifier])
    end

    local characters = PlayerDB.getCharacters(player.getUserid())
    for i = 1, #characters do
        local character = characters[i]
        character.outfit = PlayerDB.getActiveOutfit(character.charid)
        if character.outfit then
            character.outfit = json.decode(character.outfit.components)
        end

        if character.skin then
            character.skin = json.decode(character.skin)
        end
    end
    -- player.setCharacters(characters)
    TriggerClientEvent("rm:playerSpawned", _src, characters)
end)

RegisterServerEvent("rm:playerLogin", function(charid)
    local _src = source
    local player = Player.getInstance(_src)
    if player then
        local character = PlayerDB.getCharacter(charid)
        local outfit = PlayerDB.getActiveOutfit(charid)
        if outfit then
            outfit.components = json.decode(outfit.components)
        end
        character.skin = json.decode(character.skin)
        character.outfit = outfit or {}
        character.coords = json.decode(character.coords)
        character.status = json.decode(character.status)
        player.login(character)
    end
end)

RegisterServerEvent("rm:newCharacter", function(playerData)
    local _src = source
    local player = Player.getInstance(_src)
    if player then
        playerData.userid = player.getUserid()
        local userData = PlayerDB.createCharacter(playerData)
        player.login(userData)
    end
end)

RegisterServerEvent("rm:updateCoords", function(coords)
    local _src = source
    local player = Player.getInstance(_src)
    if player then
        player.setCoords(coords)
    end
end)
