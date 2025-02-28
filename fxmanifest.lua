fx_version 'cerulean'
games { 'gta5' }

author 'Weponz'
description 'Standalone Zombie System'
version '1.0.2'

client_script 'client.lua'
server_script 'server.lua'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

lua54 'yes'