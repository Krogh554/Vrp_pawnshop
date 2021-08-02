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

vRP = Proxy.getInterface("vRP")

HT = nil
Citizen.CreateThread(function()
    while HT == nil do
        TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
        Citizen.Wait(0)
    end
end)

local Pawnshop = true

local shop = {
    {x=182.84091186523,y=-1319.5063476562,z=29.317193984985}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
                for _,v in pairs(shop) do
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 2.5 then
                        DrawMarker(24, v.x,v.y,v.z-0.20, 0, 0, 0, 0, 0, 0, 0.301, 0.3001, 0.3001, 32, 92, 183, 200, 0, 0, 0, 1) 
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 1.0 then
                    DrawText3Ds(v.x,v.y,v.z,"[E] Åben | Pawnshop")
                        if IsControlJustReleased(1, Config.KeyToOpenShop) then
                            Pawnshop()
                            end
                end
        end
    end
end
end) 

function Pawnshop()
	local player = PlayerPedId()
	
	local elements = {
		{ label = "Køb", action = "PawnShop_Buy_Menu" },
		{ label = "Sælg", action = "PawnShop_Sell_Menu" },
		{ label = "Luk", action = "Luk" },
	}
		
	HT.UI.Menu.Open('default', GetCurrentResourceName(), "PawnShop_main_menu",
		{
			title    = "Pawn Shop",
			align    = "top-left",
			elements = elements
		},
	function(data, menu)
		local action = data.current.action

        if(data.current.action == 'PawnShop_Buy_Menu') then
            PawnShopBuyMenu()
		end
        if(data.current.action == 'Luk') then
            menu.close()
		end
        if(data.current.action == 'PawnShop_Sell_Menu') then
            PawnShopSellMenu()
		end
	end, function(data, menu)
        menu.close()
    end)
end
function PawnShopBuyMenu()
	local player = PlayerPedId()
	local elements = {}
			
	for k,v in pairs(Config.ItemsInPawnShop) do
		if v.BuyInPawnShop == true then
			table.insert(elements,{label = v.label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.BuyPrice..""), itemName = v.itemName, BuyInPawnShop = v.BuyInPawnShop, BuyPrice = v.BuyPrice})
		end
	end
		
	HT.UI.Menu.Open('default', GetCurrentResourceName(), "PawnShop_buy_menu",
		{
			title    = "Hvad vil du købe?",
			align    = "top-left",
			elements = elements
		},
	function(data, menu)
			if data.current.itemName == data.current.itemName then
				OpenBuyDialogMenu(data.current.itemName,data.current.BuyPrice)
			end	
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

function OpenBuyDialogMenu(itemName, BuyPrice)
	HT.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog', {
		title = "Antal du vil købe?"
	}, function(data, menu)
		menu.close()
		amountToBuy = tonumber(data.value)
		totalBuyPrice = (BuyPrice * amountToBuy)
		TriggerServerEvent("PawnShop:BuyItem",amountToBuy,totalBuyPrice,itemName)
	end,
	function(data, menu)
		menu.close()	
	end)
end

function PawnShopSellMenu()
	local player = PlayerPedId()
	local elements = {}
			
	for k,v in pairs(Config.ItemsInPawnShop) do
		if v.SellInPawnShop == true then
			table.insert(elements,{label = v.label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.SellPrice..""), itemName = v.itemName, SellInPawnShop = v.SellInPawnShop, SellPrice = v.SellPrice})
		end
	end
		
	HT.UI.Menu.Open('default', GetCurrentResourceName(), "PawnShop_sell_menu",
		{
			title    = "Hvad vil du sælge?",
			align    = "top-left",
			elements = elements
		},
	function(data, menu)
			if data.current.itemName == data.current.itemName then
				OpenSellDialogMenu(data.current.itemName,data.current.SellPrice)
			end	
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

function OpenSellDialogMenu(itemName, SellPrice)
	HT.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Dialog', {
		title = "Antal du vil Sælge?"
	}, function(data, menu)
		menu.close()
		amountToSell = tonumber(data.value)
		totalSellPrice = (SellPrice * amountToSell)
		TriggerServerEvent("PawnShop:SellItem",amountToSell,totalSellPrice,itemName)
	end,
	function(data, menu)
		menu.close()	
	end)
end

Citizen.CreateThread(function()
	blip = AddBlipForCoord(182.84091186523,-1319.5063476562,29.317193984985)
	SetBlipSprite(blip, 267)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.9)
	SetBlipColour(blip, 21)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("PawnShop")
	EndTextCommandSetBlipName(blip)
end)
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end