--[[
 _   __                _       _  _   _____  _______________ 
| | / /               | |    _| || |_|  _  ||___  /___  /   |
| |/ / _ __ ___   __ _| |__ |_  __  _| |/' |   / /   / / /| |
|    \| '__/ _ \ / _` | '_ \ _| || |_|  /| |  / /   / / /_| |
| |\  \ | | (_) | (_| | | | |_  __  _\ |_/ /./ /  ./ /\___  |
\_| \_/_|  \___/ \__, |_| |_| |_||_|  \___/ \_/   \_/     |_/
                  __/ |                                      
                 |___/                                                                        
--]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"config.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}