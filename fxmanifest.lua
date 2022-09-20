fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'RMCore is a roleplay framework for redm. Vite boilerplate used is from overextended'

name 'rm_core'
version '0.0.1'
license 'MIT'
author 'Cr1MsOn'

lua54 'yes'

dependencies {
    '/onesync',
}

shared_scripts {
    '@rm_lib/require.lua',
    'shared/*.lua',
    'clothes.lua',
    'overlays.lua'
}

client_scripts {
    'client/main.lua',
    'client/functions/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/tables/init.lua',
    'server/constants.lua',
    'server/db.lua',
    'server/player/player.db.lua',
    'server/player/player.lua',
    'server/main.lua',
    'server/functions/main.lua',
    'server/connecting.lua',
}

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*',
}
