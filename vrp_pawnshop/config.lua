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

Config = {}
Config.Rank = "Civil" -- rank for at kunne åbne shoppen --

Config.KeyToOpenShop = 38 -- hvilken knap man skal åbne menuen med [38 = E] // skift ved brug af dette link https://docs.fivem.net/docs/game-references/controls/ --

--items der skal være i shoppen-- 
Config.ItemsInPawnShop = {
	{ itemName = 'lockpick', label = 'lockpick', BuyInPawnShop = true, BuyPrice = 3500, SellInPawnShop = true, SellPrice = 2500 },
	{ itemName = 'alubar', label = 'alubar', BuyInPawnShop = true, BuyPrice = 2000, SellInPawnShop = true, SellPrice = 1200 },
	{ itemName = 'pose', label = 'pose', BuyInPawnShop = true, BuyPrice = 1500, SellInPawnShop = true, SellPrice = 1000 },
	{ itemName = 'planks', label = 'planks', BuyInPawnShop = true, BuyPrice = 800, SellInPawnShop = true, SellPrice = 400 },
}