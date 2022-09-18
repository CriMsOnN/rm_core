Player = {}
Players = {}

function Player.init(source, identifier)
    local id = PlayerDB.getPlayerFromIdentifier(identifier)

    if not id then
        id = PlayerDB.createPlayer(source, identifier)
    end

    local player = {
        source = source,
        userid = id,
        username = GetPlayerName(source),
        identifier = identifier
    }

    function player.getIdentifier()
        return player.identifier
    end

    function player.setOutfit(outfit)
        if type(outfit) ~= "string" then outfit = json.encode(outfit) end
        player.outfit = outfit
    end

    function player.getOutfit()
        return player.outfit and json.decode(player.outfit)
    end

    function player.getName()
        return player.username
    end

    function player.getUserid()
        return player.userid
    end

    function player.setCharacters(characters)
        player.characters = characters
    end

    Players[player.source] = player
    return player
end
