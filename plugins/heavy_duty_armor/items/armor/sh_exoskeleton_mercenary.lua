local ITEM = ITEM

ITEM.base = "base_armor_exoskeleton"
ITEM.price = 15000
ITEM.name = "Mercenary Exoskeleton"
ITEM.description =
	"A Mercenary™ branded exoskeleton. Provides you with great bullet resistance."
ITEM.replacement = "models/stalkertnb/exo_skat_merc.mdl"
ITEM.attribBoosts = {
	["dexterity"] = 30,
}

ix.anim.SetModelClass(ITEM.replacement, "player")
