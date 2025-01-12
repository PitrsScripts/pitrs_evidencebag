local registeredStashes = {}
local ox_inventory = exports.ox_inventory

RegisterServerEvent('pitrs_evidence:openEvidence')
AddEventHandler('pitrs_evidence:openEvidence', function(identifier)
	if not registeredStashes[identifier] then
        ox_inventory:RegisterStash('evidence_'..identifier, 'Důkazní Sáček', false)
        registeredStashes[identifier] = true
    end
end)

lib.callback.register('pitrs_evidence:getNewIdentifier', function(source, slot)
	local newId = GenerateSerial()
	ox_inventory:SetMetadata(source, slot, {identifier = newId})
	ox_inventory:RegisterStash('evidence_'..newId, 'Důkazní Sáček', false)
	registeredStashes[newId] = true
	return newId
end)


CreateThread(function()
    while GetResourceState('ox_inventory') ~= 'started' do Wait(500) end
    local swapHook = ox_inventory:registerHook('swapItems', function(payload)
        local start, destination, move_type = payload.fromInventory, payload.toInventory, payload.toType
        local count_evidences = ox_inventory:GetItem(payload.source, 'evidence', nil, true)

        if string.find(destination, 'evidence_') then
            return false
        end

        return true
    end, {
        print = false,
        itemFilter = {
            backpack = true,
        },
    })

    local createHook = exports.ox_inventory:registerHook('createItem', function(payload)
        local count_evidence = ox_inventory:GetItem(payload.inventoryId, 'evidence', nil, true)
        local playerItems = ox_inventory:GetInventoryItems(payload.inventoryId)

        if count_evidence > 0 then
            local slot = nil
            local itemName = ""

            for i, k in pairs(playerItems) do
                if k.name == 'evidence' then
                    slot = k.slot
                    itemName = k.label  
                    break
                end
            end

            Citizen.CreateThread(function()
                local inventoryId = payload.inventoryId
                local dontRemove = slot
                Citizen.Wait(1000)

                for i, k in pairs(ox_inventory:GetInventoryItems(inventoryId)) do
                    if k.name == 'evidence' and dontRemove ~= nil and k.slot ~= dontRemove then
                        local success = ox_inventory:RemoveItem(inventoryId, 'evidence', 1, nil, k.slot)
                        if success then
                        end
                        break
                    end
                end
            end)
        end
    end, {
        print = false,
        itemFilter = {
            backpack = true
        }
    })

    AddEventHandler('onResourceStop', function()
        ox_inventory:removeHooks(swapHook)
        ox_inventory:removeHooks(createHook)
    end)
end)
