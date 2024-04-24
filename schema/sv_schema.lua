util.AddNetworkString("expFlashed")
util.AddNetworkString("expTearGassed")
util.AddNetworkString("expClearEntityInfoTooltip")

local L = Format

Schema.corpses = Schema.corpses or {}
Schema.dropMode = {
	RANDOM = 1,
	ALL = 2,
	WITH_EQUIPPED = 4
}

ix.log.AddType("perkBought", function(client, ...)
	local arg = { ... }
	return L("%s bought the perk '%s'", client:Name(), arg[1])
end, FLAG_WARNING)

ix.log.AddType("generatorEarn", function(client, ...)
	local arg = { ... }
	return L("%s earned %s from their generator", client:Name(), ix.currency.Get(arg[1]))
end, FLAG_SUCCESS)

ix.log.AddType("generatorDestroy", function(client, ...)
	local arg = { ... }
	return L("%s destroyed a generator belonging to %s", IsValid(client) and client:Name() or "an unknown player", IsValid(arg[1]) and arg[1]:Name() or "an unknown player")
end, FLAG_WARNING)

ix.log.AddType("achievementAchieved", function(client, ...)
	local arg = { ... }
	return L("%s achieved the achievement '%s' and earned %d", client:Name(), arg[1], arg[2])
end, FLAG_WARNING)

ix.log.AddType("allianceCreated", function(client, ...)
	local arg = { ... }
	return L("%s created the alliance '%s'", client:Name(), arg[1])
end, FLAG_WARNING)

ix.log.AddType("allianceDeleted", function(client, ...)
	local arg = { ... }
	return L("%s deleted the alliance '%s'", client:Name(), arg[1])
end, FLAG_WARNING)

ix.log.AddType("allianceInvited", function(client, ...)
	local arg = { ... }
	return L("%s invited %s to the alliance '%s'", client:Name(), arg[1]:Name(), arg[2])
end, FLAG_WARNING)

ix.log.AddType("allianceKicked", function(client, ...)
	local arg = { ... }
	return L("%s kicked %s from the alliance '%s'", client:Name(), arg[1]:Name(), arg[2])
end, FLAG_WARNING)

ix.log.AddType("allianceLeft", function(client, ...)
	local arg = { ... }
	return L("%s left the alliance '%s'", client:Name(), arg[1])
end, FLAG_WARNING)

ix.log.AddType("allianceRankSet", function(client, ...)
	local arg = { ... }
	return L("%s set %s's rank to %s in the alliance '%s'", client:Name(), arg[1]:Name(), arg[2], arg[3])
end, FLAG_WARNING)

ix.log.AddType("schemaDebug", function(client, ...)
	local arg = {...}
	return L("(%s) function: %s, debug log: %s", client:Name(), arg[1], arg[2])
end, FLAG_DANGER)

--- Use this to force an entity info tooltip to update.
---For example when a player is being tied up, you will want to update the tooltip to show its done.
---@param client Player
---@param targetEntity? Entity
function Schema.PlayerClearEntityInfoTooltip(client, targetEntity)
	net.Start("expClearEntityInfoTooltip")
	net.WriteEntity(targetEntity or NULL)
	net.Send(client)
end

function Schema.ImpactEffect(position, scale, withSound)
	local effectData = EffectData()

	effectData:SetStart(position)
	effectData:SetOrigin(position)
	effectData:SetScale(scale)

	util.Effect("GlassImpact", effectData, true, true)

	if (withSound) then
		sound.Play("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav", position)
	end
end

function Schema.TiePlayer(client)
	local ragdollIndex = client:GetLocalVar("ragdoll")
	local ragdoll = ragdollIndex and Entity(ragdollIndex) or nil

	if (IsValid(ragdoll)) then
		local hasBadDreamer = Schema.perk.GetOwned("bad_dreamer", client)

		if (hasBadDreamer) then
			return false
		end

		-- When the player is tied up while fallen over, move their stored weapon information.
		-- Otherwise, when they get up their weapons will be returned to them.
		if (ragdoll.ixActiveWeapon) then
			client.expTiedActiveWeapon = ragdoll.ixActiveWeapon
			ragdoll.ixActiveWeapon = nil
		end

		if (ragdoll.ixWeapons) then
			client.expTiedWeapons = ragdoll.ixWeapons
			ragdoll.ixWeapons = {}
		end
	end

	client:SetRestricted(true)
	client:SetNetVar("tying")
	client:NotifyLocalized("fTiedUp")
	client:Flashlight(false)
end

function Schema.UntiePlayer(client)
	local ragdollIndex = client:GetLocalVar("ragdoll")
	local ragdoll = ragdollIndex and Entity(ragdollIndex) or nil

	client:SetRestricted(false)
	client:SetNetVar("untying")
	client:NotifyLocalized("fUntied")

	-- If they have weapon information stored, give it back to their ragdoll.
	if (IsValid(ragdoll)) then
		if (client.expTiedActiveWeapon) then
			ragdoll.ixActiveWeapon = client.expTiedActiveWeapon
		end

		if (client.expTiedWeapons) then
			ragdoll.ixWeapons = client.expTiedWeapons
		end
	else
		-- If they don't have a ragdoll, return their weapons to them.
		if (client.expTiedWeapons) then
			for _, v in ipairs(client.expTiedWeapons) do
				if (v.class) then
					local weapon = client:Give(v.class, true)

					if (v.item) then
						weapon.ixItem = v.item
					end

					client:SetAmmo(v.ammo, weapon:GetPrimaryAmmoType())
					weapon:SetClip1(v.clip)
				elseif (v.item and v.invID == v.item.invID) then
					v.item:Equip(client, true, true)
					client:SetAmmo(v.ammo, client.carryWeapons[v.item.weaponCategory]:GetPrimaryAmmoType())
				end
			end
		end

		if (client.expTiedActiveWeapon) then
			if (client:HasWeapon(client.expTiedActiveWeapon)) then
				client:SetActiveWeapon(client:GetWeapon(client.expTiedActiveWeapon))
			else
				local weapons = client:GetWeapons()
				if (#weapons > 0) then
					client:SetActiveWeapon(weapons[1])
				end
			end
		end
	end

	client.expTiedActiveWeapon = nil
	client.expTiedWeapons = nil
end

function Schema.ChloroformPlayer(client)
	client:SetNetVar("beingChloroformed")
	client:NotifyLocalized("fChloroformed")
	client:SetRagdolled(true, 15)
end

function Schema.MakeExplosion(position, scale)
	local effectData = EffectData()

	effectData:SetOrigin(position)
	effectData:SetScale(scale)

	util.Effect("explosion", effectData, true, true)
end

function Schema.GetHealAmount(client, amount)
	local healAmount = amount * (1 + Schema.GetAttributeFraction(client:GetCharacter(), "medical"))

	healAmount = hook.Run("AdjustHealAmount", client, healAmount) or healAmount

	return healAmount
end

function Schema.GetDexterityTime(client, time)
	return time * Schema.GetAttributeFraction(client:GetCharacter(), "dexterity")
end

function Schema.BustDownDoor(client, door, force)
	door.bustedDown = true
	door:SetNotSolid(true)
	door:DrawShadow(false)
	door:SetNoDraw(true)
	door:EmitSound("physics/wood/wood_box_impact_hard3.wav")
	door:Fire("Unlock", "", 0)

	local detachedDoor = ents.Create("prop_physics")

	detachedDoor:SetCollisionGroup(COLLISION_GROUP_WORLD)
	detachedDoor:SetAngles(door:GetAngles())
	detachedDoor:SetModel(door:GetModel())
	detachedDoor:SetSkin(door:GetSkin())
	detachedDoor:SetPos(door:GetPos())
	detachedDoor:Spawn()

	local physicsObject = detachedDoor:GetPhysicsObject()

	if (IsValid(physicsObject)) then
		if (not force) then
			if (IsValid(client)) then
				physicsObject:ApplyForceCenter((door:GetPos() - client:GetPos()):Normalize() * 10000)
			end
		else
			physicsObject:ApplyForceCenter(force)
		end
	end

	Schema.DecayEntity(detachedDoor, 300)

	timer.Create("Reset Door: " .. door:EntIndex(), 300, 1, function()
		if (IsValid(door)) then
			door:SetNotSolid(false)
			door:DrawShadow(true)
			door:SetNoDraw(false)
			door.bustedDown = nil
		end
	end)
end

function Schema.CleanupCorpses(maxCorpses)
	maxCorpses = maxCorpses or ix.config.Get("corpseMax", 8)
	local toRemove = {}

	if (#Schema.corpses > maxCorpses) then
		for k, corpse in ipairs(Schema.corpses) do
			if (! IsValid(corpse)) then
				toRemove[#toRemove + 1] = k
			elseif (#Schema.corpses - #toRemove > maxCorpses) then
				corpse:Remove()
				toRemove[#toRemove + 1] = k
			end
		end
	end

	for k, _ in ipairs(toRemove) do
		table.remove(Schema.corpses, k)
	end
end

function Schema.HandlePlayerDeathCorpse(client)
	if (hook.Run("ShouldSpawnPlayerCorpse") == false) then
		return
	end

	local maxCorpses = ix.config.Get("corpseMax", 8)

	if (maxCorpses == 0) then
		hook.Run("OnPlayerCorpseNotCreated", client)
		return
	end

	local entity = IsValid(client.ixRagdoll) and client.ixRagdoll or client:CreateServerRagdoll()
	local decayTime = ix.config.Get("corpseDecayTime", 60)
	local uniqueID = "ixCorpseDecay" .. entity:EntIndex()

	entity:RemoveCallOnRemove("fixer")
	entity:CallOnRemove("expPersistentCorpse", function(ragdoll)
		if (IsValid(client) and not client:Alive()) then
			client:SetLocalVar("ragdoll", nil)
		end

		local index

		for k, v in ipairs(Schema.corpses) do
			if (v == ragdoll) then
				index = k
				break
			end
		end

		if (index) then
			table.remove(Schema.corpses, index)
		end

		if (timer.Exists(uniqueID)) then
			timer.Remove(uniqueID)
		end

		if (not client.expCorpseCharacter and not client:GetCharacter()) then
			-- Can happen when the server is shutting down, removing all ents
			return
		end

		hook.Run("OnPlayerCorpseRemoved", client, ragdoll)
	end)

	if (decayTime > 0) then
		local visualDecayTime = math.max(decayTime * .1, math.min(10, decayTime))

		timer.Create(uniqueID, decayTime - visualDecayTime, 1, function()
			if (IsValid(entity)) then
				Schema.DecayEntity(entity, visualDecayTime)
			else
				timer.Remove(uniqueID)
			end
		end)
	end

	-- Remove reference to ragdoll so it isn't removed on spawn when SetRagdolled is called
	client.ixRagdoll = nil
	-- Remove reference to the player so no more damage can be dealt
	entity.ixPlayer = nil

	Schema.corpses[#Schema.corpses + 1] = entity

	if (#Schema.corpses >= maxCorpses) then
		Schema.CleanupCorpses(maxCorpses)
	end

	client:SetLocalVar("ragdoll", entity:EntIndex())

	hook.Run("OnPlayerCorpseCreated", client, entity)
end

function Schema.SearchPlayer(client, target)
	if (not target:GetCharacter() or not target:GetCharacter():GetInventory()) then
		return false
	end

	local name = hook.Run("GetDisplayedName", target) or target:Name()
	local inventory = target:GetCharacter():GetInventory()

	ix.storage.Open(client, inventory, {
		entity = target,
		name = name
	})

	return true
end

function Schema.MakeFlushToGround(entity, position, normal)
	local lowestPoint = entity:NearestPoint(position - (normal * 512))
	entity:SetPos(position + (entity:GetPos() - lowestPoint))
end

function Schema.CanSeePosition(client, position, allowance, ignoreEnts)
	local trace = {}

	trace.mask = CONTENTS_SOLID
		+ CONTENTS_MOVEABLE
		+ CONTENTS_OPAQUE
		+ CONTENTS_DEBRIS
		+ CONTENTS_HITBOX
		+ CONTENTS_MONSTER
	trace.start = client:GetShootPos()
	trace.endpos = position
	trace.filter = { client }

	if (ignoreEnts) then
		if (type(ignoreEnts) == "table") then
			table.Add(trace.filter, ignoreEnts)
		else
			table.Add(trace.filter, ents.GetAll())
		end
	end

	trace = util.TraceLine(trace)

	if (trace.Fraction >= (allowance or 0.75)) then
		return true
	end
end

function Schema.DecayEntity(entity, seconds, callback)
	local color = entity:GetColor()
	local alpha = color.a
	local subtract = math.ceil(alpha / seconds)
	local index

	if (entity.decaying) then
		index = entity.decaying
	else
		index = tostring({}) -- will be unique
		entity.decaying = index
	end

	entity:SetRenderMode(RENDERMODE_TRANSALPHA)

	local name = "Decay: " .. index

	timer.Create(name, 1, 0, function()
		alpha = alpha - subtract

		if (not IsValid(entity)) then
			timer.Remove(name)
			return
		end

		local color = entity:GetColor()
		local decayed = math.Clamp(math.ceil(alpha), 0, 255)

		if (color.a > 0) then
			entity:SetColor(Color(color.r, color.g, color.b, decayed))
			return
		end

		if (callback) then
			callback()
		end

		entity:Remove()
		timer.Remove(name)
	end)
end
