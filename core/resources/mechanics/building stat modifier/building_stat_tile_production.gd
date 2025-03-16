class_name BuildingStatTileProduction
extends BaseBuildingStatModifier

@export var stat: Building.Stat
@export var override: bool= true
@export var replace_with_own_base_stat: bool= false
@export var tier_factors: Array[int]
@export var buildings: Array[Building]
@export var terrains: Array[Terrain]
@export var features: Array[TerrainFeature]
@export var raw_materials: Array[RawMaterial]
@export var only_raw_materials: bool= true



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, city: CityInstance)-> int:
	var result: int= process_tile(tile, building, building_tier, world, city)
	if result == 0 and not override:
		return base_value
	return result


func process_tile(tile: Vector2i, building: Building, building_tier: int, world: World, city: CityInstance)-> int:
	var production= null
	
	var other_building: Building= world.get_building(tile)
	if other_building and other_building in buildings:
		production= other_building.get_stat(Building.Stat.PRODUCTION, building_tier, tile, world, city)
	else:
		var raw_material: RawMaterial= world.get_raw_material(tile, only_raw_materials)
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
	
	if production != null and replace_with_own_base_stat:
		production= building.get_base_stat(stat, building_tier)
	
	if production == null:
		production= 0
	
	return production * (1 if tier_factors.is_empty() else tier_factors[mini(building_tier, tier_factors.size() - 1)])


func get_stat()-> Building.Stat:
	return stat


func get_short_desc()-> String:
	return "From Tiles"
