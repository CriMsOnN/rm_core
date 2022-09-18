RMCore = {}
RMCore.Functions = {}


RegisterServerEvent("rm:playerSpawned", function()
    local _src = source
    local player = Players[_src]
    if not player then
        local identifiers = RMCore.Functions.getIdentifiers(_src)
        player = Player.init(_src, identifiers[Config.defaultIdentifier])
    end

    local characters = PlayerDB.getCharacters(player.getUserid())
    for i = 1, #characters do
        local character = characters[i]
        character.outfit = PlayerDB.getActiveOutfit(character.charid)
    end
    player.setCharacters(characters)
    TriggerClientEvent("rm:playerSpawned", _src, characters)
end)
