local loadingPlayers = {}
exports('getLoadingPlayers', function() return loadingPlayers end)

local DB <const> = require 'db'
local Player <const> = require 'player/player'

exports('playerConnecting', function(source, name, reason, deferrals)
    local _src = source
    local identifiers = lib.getIdentifiers(_src)
    local identifier = identifiers[Config.defaultIdentifier]

    deferrals.update("Checking your identifiers..")
    Wait(100)
    if not identifier then
        deferrals.done('You need to have steam open to player on this server!')
        exports.rm_queue:removePlayerFromQueue(identifier)
        return
    end

    if loadingPlayers[identifier] then
        deferrals.done('You are already connecting to the server!')
        exports.rm_queue:removePlayerFromQueue(identifier)
        return
    end

    deferrals.update("Checking whitelist...")
    Wait(500)
    local whitelisted = DB.isWhitelisted(identifier)
    if not whitelisted then
        deferrals.done('You are not whitelisted on this server!')
        exports.rm_queue:removePlayerFromQueue(identifier)
        return
    end
    local player = Player.init(_src, identifier)
    loadingPlayers[identifier] = player
    deferrals.done()
end)


AddEventHandler("playerJoining", function(source)
    local _src = source
    local identifiers = lib.getIdentifiers(_src)
    local loadingPlayer = loadingPlayers[identifiers[Config.defaultIdentifier]]
    if loadingPlayer then
        loadingPlayers[identifiers[Config.defaultIdentifier]] = nil
    end
end)
