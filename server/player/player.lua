local Player = {}
local Players = {}

local PlayerDB <const> = requireLocal 'player/player.db'

function Player.init(source, identifier)
    local id = PlayerDB.getPlayerFromIdentifier(identifier)

    if not id then
        id = PlayerDB.createPlayer(source, identifier)
    end

    local self = {
        source = source,
        userid = id,
        username = GetPlayerName(source),
        identifier = identifier
    }

    function self.getIdentifier()
        return self.identifier
    end

    function self.setOutfit(outfit)
        if type(outfit) ~= "string" then outfit = json.encode(outfit) end
        self.outfit = outfit
    end

    function self.getOutfit()
        return self.outfit and json.decode(self.outfit)
    end

    function self.getName()
        return self.username
    end

    function self.getUserid()
        return self.userid
    end

    function self.setJob(job, job_grade)
        self.job = {
            job_name = job,
            job_grade = job_grade
        }
    end

    function self.login(playerData)
        self.firstname = playerData.firstname
        self.lastname = playerData.lastname
        self.skin = playerData.skin
        self.sex = playerData.sex
        self.outfit = playerData.outfit
        self.status = playerData.status
        self.coords = vector3(playerData.coords.x, playerData.coords.y, playerData.coords.z)
        self.job = {
            job_name = playerData.job,
            job_grade = playerData.job_grade
        }
        TriggerClientEvent("rm:playerLogin", self.source, self)
    end

    function self.getJob()
        return self.job
    end

    function self.addCharacter(character)
        table.insert(self.characters, character)
    end

    Players[self.source] = self
    return self
end

function Player.getInstance(source)
    return Players[source]
end

exports('getPlayer', Player.getInstance)
return Player
