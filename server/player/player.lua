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

    function player.setJob(job, job_grade)
        player.job = {
            job_name = job,
            job_grade = job_grade
        }
    end

    function player.login(playerData)
        player.firstname = playerData.firstname
        player.lastname = playerData.lastname
        player.skin = playerData.skin
        player.sex = playerData.sex
        player.outfit = playerData.outfit
        player.status = playerData.status
        player.coords = vector3(playerData.coords.x, playerData.coords.y, playerData.coords.z)
        player.job = {
            job_name = playerData.job,
            job_grade = playerData.job_grade
        }
        TriggerClientEvent("rm:playerLogin", player.source, player)
    end

    function player.getJob()
        return player.job
    end

    -- function player.setCharacters(characters)
    --     player.characters = characters
    -- end

    function player.addCharacter(character)
        table.insert(player.characters, character)
    end

    Players[player.source] = player
    return player
end
