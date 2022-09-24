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
        TriggerClientEvent("rm:playerLogin", self.source, {
            firstname = self.firstname,
            lastname = self.lastname,
            coords = lib.toVector3(playerData.coords),
            job = self.job,
            outfit = self.outfit,
            sex = self.sex,
            skin = self.skin,
            status = self.status
        })
        TriggerEvent("rm:playerLoginServer", self.source)
    end

    function self.getJob()
        return self.job
    end

    function self.addCharacter(character)
        table.insert(self.characters, character)
    end

    function self.setCoords(coords)
        if type(coords) ~= "vector3" then coords = lib.toVector3(coords) end
        self.coords = coords
    end

    function self.getCoords(coords)
        return self.coords
    end

    function self.removeStatus(statusType, statusValue)
        print(statusType, statusValue)
        if self.status[statusType] then
            self.status[statusType] = self.status[statusType] - statusValue
            if self.status[statusType] < 0 then self.status[statusType] = 0 end
            TriggerClientEvent("status:updateStatus", self.source, statusType, self.status[statusType])
        end
    end

    function self.addStatus(statusType, statusValue)
        if self.status[statusType] then
            self.status[statusType] = self.status[statusType] + statusValue
            TriggerClientEvent("status:updateStatus", self.source, statusType, self.status[statusType])
        end
    end

    function self.createStatus(statusType, statusValue)
        if not self.status[statusType] then
            self.status[statusType] = statusValue
            TriggerClientEvent('rm_status:create', self.source, statusType, statusValue)
        end
    end

    Players[self.source] = self
    return self
end

function Player.getInstance(source)
    return Players[source]
end

exports('getPlayer', Player.getInstance)
exports('getPlayers', function()
    return Players
end)


return Player
