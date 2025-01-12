local bagEquipped, bagObj
local ox_inventory = exports.ox_inventory
local justConnect = true

AddEventHandler('ox_inventory:updateInventory', function(changes)
    if justConnect then
        Wait(4500)
        justConnect = nil
    end
    for k, v in pairs(changes) do
        if type(v) == 'table' then
            local count = ox_inventory:Search('count', 'evidence')
            if count > 0 then
                bagEquipped = true
            elseif count < 1 and bagEquipped then
                bagEquipped = false
            end
        end
        if type(v) == 'boolean' then
            local count = ox_inventory:Search('count', 'evidence')
            if count < 1 and bagEquipped then
                bagEquipped = false
            end
        end
    end
end)

exports('openEvidence', function(data, slot)
    if not slot?.metadata?.identifier then
        local identifier = lib.callback.await('pitrs_evidence:getNewIdentifier', 100, data.slot)
        ox_inventory:openInventory('stash', 'evidence_'..identifier)
    else
        TriggerServerEvent('pitrs_evidence:openEvidence', slot.metadata.identifier)
        ox_inventory:openInventory('stash', 'evidence_'..slot.metadata.identifier)
    end
end)
