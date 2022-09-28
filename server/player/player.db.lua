local PlayerDB = {}
local MySQL = MySQL

local Constants <const> = require 'constants'

function PlayerDB.getPlayerFromIdentifier(identifier)
    local results = MySQL.single.await(Constants.GET_USERID, { identifier })
    return results
end

function PlayerDB.createPlayer(source, identifier)
    local username = GetPlayerName(source)
    local results = MySQL.insert.await(Constants.CREATE_USER, { username, identifier })
    return results
end

function PlayerDB.getCharacters(userid)
    local results = MySQL.query.await(Constants.GET_CHARACTERS, { userid })
    return results
end

function PlayerDB.createCharacter(data)
    local userData = {
        firstname = data.firstname,
        lastname = data.lastname,
        skin = type(data.skin) ~= "string" and json.encode(data.skin) or data.skin,
        sex = data.sex,
        userid = data.userid,
        outfit = {
            outfitname = data.outfitName,
            components = data.outfit,
            active = 1
        },
        status = {},
        job = "unemployed",
        job_grade = 0,
        coords = {
            x = Config.newPlayer.defaultSpawn.x,
            y = Config.newPlayer.defaultSpawn.y,
            z = Config.newPlayer.defaultSpawn.z
        }
    }

    for k, v in pairs(Config.status) do
        userData.status[k] = v.defaultValue
    end

    userData.status = json.encode(userData.status)
    local charid = MySQL.insert.await(Constants.CREATE_CHARACTER,
        { userData.userid, userData.firstname, userData.lastname, userData.sex, userData.status, userData.skin,
            json.encode(userData.coords), userData.job, userData.job_grade })
    PlayerDB.createOufit({
        charid = charid,
        outfitname = data.outfitName,
        components = data.outfit,
        active = 1
    })
    return userData
end

function PlayerDB.createOufit(data)
    MySQL.insert.await(Constants.CREATE_OUTFIT,
        { data.charid, data.outfitname, json.encode(data.components), data.active })
end

function PlayerDB.getActiveOutfit(charid)
    local outfit = MySQL.single.await(Constants.GET_ACTIVEOUTFIT, { charid, 1 })
    return outfit
end

function PlayerDB.getCharacter(charid)
    local character = MySQL.single.await(Constants.GET_CHARACTER, { charid })
    return character
end

return PlayerDB
