fx_version 'cerulean'
game 'gta5'
lua54 'yes'

Author 'Pitrs'
description 'Evidence script for Ox Inventory'
version '1.0.0'

client_scripts {
    'client/**.lua'
}

server_scripts {
  'server/**.lua'
}

shared_scripts {
  '@ox_lib/init.lua'
}

dependencies {
  'ox_inventory'
}
