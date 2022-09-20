TABLES = {
    users = [[
        CREATE TABLE IF NOT EXISTS `users` (
            `userid` int(11) NOT NULL AUTO_INCREMENT,
            `username` varchar(50) DEFAULT NULL,
            `identifier` varchar(50) DEFAULT NULL,
            KEY `userid` (`userid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]],
    characters = [[
        CREATE TABLE IF NOT EXISTS `characters` (
            `charid` int(11) NOT NULL AUTO_INCREMENT,
            `userid` int(11) DEFAULT NULL,
            `firstname` varchar(50) DEFAULT NULL,
            `lastname` varchar(50) DEFAULT NULL,
            `dateofbirth` date DEFAULT NULL,
            `sex` varchar(50) DEFAULT NULL,
            `status` longtext DEFAULT '[]',
            `skin` longtext DEFAULT '[]',
            `coords` longtext DEFAULT NULL,
            `job` varchar(50) DEFAULT NULL,
            `job_grade` varchar(50) DEFAULT NULL,
            KEY `charid` (`charid`)
        ) ENGINE=InnoDB CHARSET=utf8mb4;
    ]],
    characters_outfits = [[
        CREATE TABLE IF NOT EXISTS `characters_outfits` (
            `charid` int(11) DEFAULT NULL,
            `outfitname` varchar(50) DEFAULT NULL,
            `components` longtext DEFAULT NULL,
            `active` tinyint(2) DEFAULT 0
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]],
    whitelists = [[
        CREATE TABLE IF NOT EXISTS `whitelist` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `identifier` varchar(50) DEFAULT NULL,
            KEY `id` (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]],
    priorities = [[
        CREATE TABLE IF NOT EXISTS `priorities` (
            `identifier` varchar(50) DEFAULT NULL,
            `priority` int(11) DEFAULT NULL,
            `expires` date DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]]
}

CreateThread(function()
    local tablesCreated = {}
    for k, v in pairs(TABLES) do
        local results = MySQL.query.await(v)
        if results.affectedRows > 0 then
            table.insert(tablesCreated, k)
        end
    end
    if #tablesCreated > 0 then
        print(('Tables created: %s'):format(json.encode(tablesCreated)))
    else
        print('^2All tables are updated!^0')
    end
end)
