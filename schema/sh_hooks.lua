function Schema:DoPluginIncludes(path, plugin)
	ix.util.IncludeDir(path .. "/achievements", true)
	ix.util.IncludeDir(path .. "/perks", true)
end

function Schema:PlayerTick(client, moveData)
	if (self.nextPlayerTick and CurTime() < self.nextPlayerTick) then
		return
	end

	self.nextPlayerTick = CurTime() + 1

	hook.Run("PlayerSecondElapsed", client)
end

function Schema:CanPlayerUseBusiness(client, uniqueID)
	local itemTable = ix.item.list[uniqueID]

	if (itemTable.OnCanOrder) then
		return itemTable:OnCanOrder(client)
	end
end

function Schema:InitializedSchema()
	local items = ix.item.list

	for _, item in pairs(items) do
		if (item.isAttachment and item.class ~= nil) then
			Schema.RegisterWeaponAttachment(item)
		end

		if (item.forcedWeaponCalibre) then
			if (not item.class) then
				ErrorNoHalt("Item " .. item.uniqueID .. " does not have a class, can't force bullet calibre.")
				continue
			end

			Schema.ammo.ForceWeaponCalibre(item.class, item.forcedWeaponCalibre)
		end
	end
end

function Schema:PlayerFootstep(client, position, foot, soundName, volume, filter)
	local character = client:GetCharacter()

	if (not character) then
		return true
	end

	local mode = client:IsRunning() and "run" or "walk"

	if (mode == "walk" and Schema.perk.GetOwned(PRK_LIGHTSTEP, client)) then
		return true
	end

	if (client:IsBot()) then
		-- Bots wont have an inventory
		return
	end

	local inventory = character:GetInventory()
	local soundOverride

	for _, item in pairs(inventory:GetItems()) do
		if (not item:GetData("equip") or not item.footstepSounds) then
			continue
		end

		local footstepSounds = item.footstepSounds[mode]

		if (not footstepSounds) then
			continue
		end

		soundOverride = footstepSounds[math.random(#footstepSounds)]
	end

	if (soundOverride) then
		EmitSound(soundOverride, position, 0, CHAN_BODY, volume, 75, 0, 100, 0, filter)
		return true
	end
end
