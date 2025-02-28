fx_version 'cerulean'
games { 'gta5' }

author 'PenguScripts'
description 'A lightweight resource that allows players to upgrade their vehicles!'
version '1.0.0'

client_script 'client.lua'
server_script 'server.lua'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

lua54 'yes'
