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

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

HT = nil
TriggerEvent('HT_base:getBaseObjects', function(obj)
    HT = obj
end)

HT.RegisterServerCallback('Rank:checkForJob', function(source, cb)
    local user_id = vRP.getUserId({source})

    if vRP.hasGroup({user_id, Config.Rank}) then
        cb(true)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Ingen Adgang!', length = 2500, style = { ['background-color'] = '#1e5d76', ['color'] = '#ffffff' } })
        cb(false)
    end
end)
RegisterServerEvent("PawnShop:BuyItem")
AddEventHandler("PawnShop:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local user_id = vRP.getUserId({source})
    if vRP.getMoney({user_id}) >= totalBuyPrice then
		vRP.tryFullPayment({user_id,totalBuyPrice})
		vRP.giveInventoryItem({user_id,itemName,amountToBuy,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = "Du betalte $"..totalBuyPrice.. "for " ..amountToBuy..""..itemName.."", length = 2500, style = { ['background-color'] = '#1e5d76', ['color'] = '#ffffff' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok penge', length = 2500, style = { ['background-color'] = '#dc1313', ['color'] = '#ffffff' } })
    end
end)

RegisterServerEvent("PawnShop:SellItem")
AddEventHandler("PawnShop:SellItem", function(amountToSell,totalSellPrice,itemName)
    local user_id = vRP.getUserId({source})
    if vRP.getInventoryItemAmount({user_id,itemName}) > amountToSell then
        vRP.giveMoney({user_id,totalSellPrice})
        vRP.tryGetInventoryItem({user_id,itemName,amountToSell})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Du solgte "..amountToSell..""..itemName.." for $"..totalSellPrice.."", length = 2500, style = { ['background-color'] = '#4ad066', ['color'] = '#ffffff' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du magngler'..itemName.."" ,length = 2500, style = { ['background-color'] = '#dc1313', ['color'] = '#ffffff' } })
    end
end)