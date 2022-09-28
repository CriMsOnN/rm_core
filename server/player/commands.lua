local Player = require 'player/player'


lib.addCommand('group.admin', 'setPermission', function(source, args)
    local player = Player.getInstance(args.target)
    if player then
        player.setPermission(args.permission)
    end
end, { "target:number", "permission:string" })

lib.addCommand('group.user', 'logout', function(source, args)
    local player = Player.getInstance(source)
    player.logout()
end)
