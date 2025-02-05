local ITEM = ITEM

ITEM.name = "Bolt Generator Protector"
ITEM.price = 100
ITEM.model = "models/props_combine/breenlight.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.noDrop = true
ITEM.category = "Protection"
ITEM.description = "When placed near a Bolt Generator it will reduce the damage they take by 50%%. This is not permanent and can be destroyed by others."
ITEM.maximum = 5

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		if (not self.maximum) then
			return
		end

		local panel = tooltip:AddRowAfter("name", "maximum")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText("You can only have " .. self.maximum .. " of this item in the world at a time!")
		panel:SizeToContents()
	end
end

ITEM.functions.Place = {
	OnRun = function(item)
		local client = item.player

        if (client:IsObjectLimited("boltProtectors", item.maximum)) then
            client:Notify("You can not place this as you have reached the maximum amount of this item!")
            return false
        end

		local success, message, trace = client:TryTraceInteractAtDistance()

		if (not success) then
			client:Notify(message)

			return false
		end

		local entity = ents.Create("exp_bolt_protector")
		entity:SetupBoltProtector(client)
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		client:AddLimitedObject("boltProtectors", entity)
		client:RegisterEntityToRemoveOnLeave(entity)
		Schema.MakeFlushToGround(entity, trace.HitPos, trace.HitNormal)
	end,

	OnCanRun = function(item)
        local client = item.player

        -- Ensure it's in the player's inventory
        if (not client or item.invID ~= client:GetCharacter():GetInventory():GetID()) then
            return false
        end

		local success, message, trace = client:TryTraceInteractAtDistance()

		if (not success) then
			return false
		end

		return true
	end
}
