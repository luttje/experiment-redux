local PLUGIN = PLUGIN

PLUGIN.name = "Damage Numbers"
PLUGIN.author = "Experiment Redux"
PLUGIN.description = "Display damage numbers when you hit someone, or when you get hit."

if (CLIENT) then
	local damageNumbers = {}
	local damageNumberFont = "expDamageNumber"
	local damageNumberTime = 2
	local baseAlpha = 125

	function PLUGIN:LoadFonts(headingFont, readableFont)
		surface.CreateFont("expDamageNumber", {
			font = headingFont,
			size = 24,
			extended = true,
			weight = 600
		})
	end

	function PLUGIN:DrawDamageNumbers()
		for k, damageNumber in ipairs(damageNumbers) do
			local alpha = baseAlpha
			local timeLeft = damageNumber.time - CurTime()

			if (timeLeft < damageNumberTime) then
				alpha = baseAlpha * (timeLeft / damageNumberTime)
			end

			local screenPos = damageNumber.pos:ToScreen()

			if (not screenPos.visible) then
				continue
			end

			draw.SimpleTextOutlined(
				damageNumber.text,
				damageNumberFont,
				screenPos.x,
				screenPos.y - ((255 - alpha) / 2),
				ColorAlpha(damageNumber.color, alpha),
				TEXT_ALIGN_CENTER,
				TEXT_ALIGN_CENTER,
				1,
				Color(0, 0, 0, alpha)
			)

			if (timeLeft <= 0) then
				table.remove(damageNumbers, k)
			end
		end
	end

	function PLUGIN:HUDPaint()
		self:DrawDamageNumbers()
	end

	net.Receive("expDamageNumbers", function()
		local entity = net.ReadEntity()
		local damage = net.ReadUInt(32)
		local client = LocalPlayer()

		if (not IsValid(entity) or not IsValid(client)) then
			return
		end

		local color = Color(83, 167, 125)
		local pos = client:GetShootPos()

		if (entity == client) then
			color = Color(255, 0, 0)

			pos = pos + client:GetAimVector() * 10
			pos = pos + VectorRand()
		else
			pos = pos + client:GetAimVector() * pos:Distance(entity:GetPos())
			pos = pos + VectorRand(-5, 5)
		end

		table.insert(damageNumbers, {
			time = CurTime() + damageNumberTime,
			text = tostring(damage),
			pos = pos,
			color = color
		})
	end)
end

if (SERVER) then
	util.AddNetworkString("expDamageNumbers")

	function PLUGIN:PostEntityTakeDamage(entity, damageInfo, tookDamage)
		if (not tookDamage) then
			return
		end

		if (not entity:IsPlayer() and not entity:IsNPC()) then
			return
		end

		local attacker = damageInfo:GetAttacker()

		if (not IsValid(attacker) or (not attacker:IsPlayer() and not attacker:IsNPC())) then
			return
		end

		net.Start("expDamageNumbers")
		net.WriteEntity(entity)
		net.WriteUInt(math.ceil(damageInfo:GetDamage()), 32)
		net.Send({
			entity,
			attacker,
		})
	end
end
