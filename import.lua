if not IsDuplicityVersion() then
    Client = {
        playerData = {},
        isLoading = true,
        getState = function(key)
            return LocalState.state[key]
        end,
        setState = function(key, value, replicate)
            return LocalState.state:set(key, value, replicate)
        end
    }

    RegisterNetEvent("rm:playerLogin", function(playerData)
        Client.playerData = playerData
        Client.isLoading = false
    end)

    RegisterNetEvent("rm:setPlayerData", function(playerData)
        Client.playerData = playerData
    end)

    RegisterNetEvent("rm:setJob", function(oldJob, newJob)
        Client.playerData.job = newJob
        Client.playerData.previousJob = oldJob
    end)

    RegisterNetEvent("rm:setCurrency", function(cType, cAmount)
        if Client.playerData.currency[cType] then
            Client.playerData.currency[cType] = cAmount
        end
    end)


    RegisterNetEvent("rm:setInventory", function(inventory)
        Client.playerData.inventory = inventory
    end)

else
    RMCore = {}

    function RMCore.getPlayer(source)
        return exports.rm_core:getPlayer(source)
    end

    function RMCore.getPlayersByJob(job, filterByGrade)
        local players = exports.rm_core:getPlayers()
        local playersInJob = {}
        for k, v in pairs(players) do
            if v.job ~= nil and v.job.job_name == job then
                table.insert(playersInJob, {
                    source = v.source,
                    job_name = v.job.job_name,
                    job_grade = v.job.job_grade
                })
            end
        end

        if filterByGrade then
            table.sort(playersInJob, function(a, b)
                return a.job_grade > b.job_grade
            end)
        end

        return playersInJob
    end

    function RMCore.getAllPlayers()
        return exports.rm_core:getPlayers()
    end
end
