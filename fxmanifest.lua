fx_version 'adamant'

game 'gta5'

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server.lua'
}

dependencies {
	'esx_vehicleshop'
}