local ITEM = ITEM

ITEM.calibre = "7.62x51mm"
ITEM.name = ITEM.calibre .. " Cartridge"
ITEM.ammo = Schema.ammo.ConvertToAmmo(ITEM.calibre)
ITEM.model = "models/experiment-redux/ammo/7_62x51.mdl"
ITEM.noBusiness = true
ITEM.ammoAmount = 1
ITEM.description = "A single 7.62x51mm cartridge"
ITEM.chanceToScavenge = 2

if (SERVER) then
	resource.AddFile("models/experiment-redux/ammo/7_62x51.mdl")
    resource.AddFile("materials/models/experiment-redux/ammo/7_62x51.vmt")
end
