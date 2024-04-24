local ITEM = ITEM

ITEM.base = "base_armor_exoskeleton"
ITEM.price = 18000
ITEM.name = "Duty Exoskeleton"
ITEM.description =
	"A Duty™ branded exoskeleton. Provides you with great bullet resistance."
ITEM.replacement = "models/stalkertnb/exo_skat_duty.mdl"
ITEM.attribBoosts = {
	["endurance"] = 20,
}

ix.anim.SetModelClass(ITEM.replacement, "player")
