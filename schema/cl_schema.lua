Schema.stunEffects = {}

function Schema.GetCachedTextSize(font, text)
	if (not Schema.CachedTextSizes) then
		Schema.CachedTextSizes = {}
	end

	if (not Schema.CachedTextSizes[font]) then
		Schema.CachedTextSizes[font] = {}
	end

	if (not Schema.CachedTextSizes[font][text]) then
		surface.SetFont(font)

		Schema.CachedTextSizes[font][text] = { surface.GetTextSize(text) }
	end

	return unpack(Schema.CachedTextSizes[font][text])
end

net.Receive("exp_TearGassed", function()
	Schema.tearGassed = CurTime() + 20
end)

net.Receive("exp_Flashed", function()
	local curTime = CurTime()

	Schema.stunEffects[#Schema.stunEffects + 1] = {
		endAt = curTime + 10,
		duration = 10,
	}
	Schema.flashEffect = {
		endAt = curTime + 20,
		duration = 20,
	}

	surface.PlaySound("hl1/fvox/flatline.wav")
end)

net.Receive("exp_ClearEffects", function()
	Schema.stunEffects = {}
	Schema.flashEffect = nil
	Schema.tearGassed = nil
end)
