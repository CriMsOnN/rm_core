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
    '@ox_lib/init.lua',
    '@ox_lib/natives.lua',
    'shared/config.lua',
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
    'server/main.lua',
    'server/connecting.lua',
}

ui_page 'web/build/index.html'

files {
    'import.lua',
    'dataview.lua',
    'web/build/index.html',
    'web/build/**/*',
}
