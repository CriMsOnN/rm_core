local MySQL = MySQL
local DB = {}

local GET_WHITELIST = "SELECT * FROM whitelist WHERE identifier = ?"
function DB.isWhitelisted(identifier)
    local results = MySQL.scalar.await(GET_WHITELIST, { identifier })
    return results and true or false
end

return DB
