FACTION.name = "Citizen"
FACTION.description = "A test subject, living in this city."
FACTION.color = Color(150, 125, 100, 255)
FACTION.isDefault = true
-- FACTION.pay = 100 -- We make the bolt generation (with BCU) the only source of income so salary doesnt spawn out of nowhere
-- FACTION.payTime = 300

function FACTION:OnCharacterCreated(client, character)
    character:SetData("buffs", {
        Schema.buff.MakeStored(client, "newbie")
    })
end

if (SERVER) then
    -- HL2RP Enhanced Citizens (Playermodels) (https://steamcommunity.com/sharedfiles/filedetails/?id=3031604368&searchtext=citizen)
    resource.AddWorkshop("3031604368")
end

local bodygroups = "052000000"

FACTION.models = {
	{ "models/hl2rp/citizens/male_01.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/female_01.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_02.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/female_04.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_03.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_09.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/female_02.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_06.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/female_03.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_05.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/female_06.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_04.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_07.mdl", 0, bodygroups },
	{ "models/hl2rp/citizens/male_08.mdl", 0, bodygroups },
}

for _, modelData in ipairs(FACTION.models) do
    ix.anim.SetModelClass(modelData[1], "player")
end

FACTION_CIVILIAN = FACTION.index
