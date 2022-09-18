local loadingPlayers = {}

AddEventHandler('playerConnecting', function(name, reason, deferrals)
    local _src = source
    deferrals.defer()
    local identifiers = RMCore.Functions.getIdentifiers(_src)
    local identifier = identifiers[Config.defaultIdentifier]

    deferrals.update("Checking your identifiers..")
    Wait(100)
    if not identifier then
        deferrals.done('You need to have steam open to player on this server!')
        return
    end

    if loadingPlayers[identifier] then
        deferrals.done('You are already connecting to the server!')
        return
    end

    deferrals.update("Checking whitelist...")
    Wait(500)
    local whitelisted = DB.isWhitelisted(identifier)
    if not whitelisted then
        deferrals.done('You are not whitelisted on this server!')
        return
    end
    local player = Player.init(_src, identifier)
    loadingPlayers[player.source] = player
    deferrals.done()
end)

AddEventHandler("playerJoining", function(source)
    local _src = source
    local loadingPlayer = loadingPlayers[_src]

    if loadingPlayer then
        loadingPlayers[source] = nil
    end
end)
