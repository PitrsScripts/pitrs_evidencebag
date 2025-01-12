# Pitrs_EvidenceBag

# Features
- 0.00ms
  
# Installation


go to ox_inventory/modules/items/containers.lua place

```
setContainerProperties('evidence', {
	slots = 40,
	maxWeight = 150000,
	--whitelist = { 'money', 'driver_license', 'weaponlicense', 'lawyerpass', 'membership', 'id_card' } 
})
```
And go to ox_inventory/data/items.lua place


```
['evidence'] = {
		label = 'Evidence Bag',
		weight = 120,
		stack = false,
		consume = 0,
		client = {
			export = 'pitrs_evidence.openEvidence'
		}
	},
```

# Dependency
- ESX
- OX_LIB
- OX_INVENTORY

