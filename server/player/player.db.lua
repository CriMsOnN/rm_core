PlayerDB = {}
local MySQL = MySQL

function PlayerDB.getPlayerFromIdentifier(identifier)
    local results = MySQL.scalar.await(Constants.GET_USERID, { identifier })
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
        userid = data.user,
        outfit = type(data.outfit) ~= "string" and json.encode(data.outfit) or data.outfit,
        status = {}
    }

    for k, v in pairs(Config.status) do
        userData.status[k] = v.defaultValue
    end
    userData.status = json.encode(userData.status)
    local charid = MySQL.insert.await(Constants.CREATE_CHARACTER,
        { userData.userid, userData.firstname, userData.lastname, userData.sex, userData.status, userData.skin })
    PlayerDB.createOufit({
        charid = charid,
        outfitname = data.outfitname,
        components = data.outfit,
        active = 1
    })
    return userData
end

function PlayerDB.createOufit(data)
    MySQL.insert.await(Constants.CREATE_OUTFIT, { data.charid, data.outfitname, data.components, data.active })
end

function PlayerDB.getActiveOutfit(charid)
    local outfit = MySQL.single.await(Constants.GET_ACTIVEOUTFIT, { charid, 1 })
    return outfit and json.decode(outfit.components)
end
