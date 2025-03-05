class_name BuildingStatTileProduction
extends BaseBuildingStatModifierWithStat

@export var tier_factors: Array[int]
@export var buildings: Array[Building]
@export var terrains: Array[Terrain]
@export var features: Array[TerrainFeature]
@export var raw_materials: Array[RawMaterial]



func process_tile(tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	var production: int= 0
	
	var building: Building= world.get_building(tile)
	if building and building in buildings:
		production= building.get_stat(Building.Stat.PRODUCTION, building_tier, tile, world, island)
	else:
		var raw_material: RawMaterial= world.get_raw_material(tile, true)
		if raw_material in raw_materials:
			production= raw_material.base_production
		else:
			var feature: TerrainFeature= world.get_feature(tile)
			if feature and feature in features:
				production= feature.base_production
			else:
				var terrain: Terrain= world.get_terrain(tile)
				if terrain in terrains:
					production= terrain.base_production

	return production * tier_factors[mini(building_tier, tier_factors.size())]
