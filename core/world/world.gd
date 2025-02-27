class_name World
extends Node

@export var generator: WorldGenerator
@export var chunk_size: int= 32

@onready var tile_map_terrain: TileMapLayer = $"TileMap Terrain"
@onready var tile_map_terrain_features: TileMapLayer = $"TileMap Terrain Features"
@onready var tile_map_buildings: TileMapLayer = $"TileMap Buildings"
@onready var tile_map_building_levels: TileMapLayer = $"TileMap Building Levels"
@onready var tile_map_buildings_ghost: TileMapLayer = $"TileMap Buildings Ghost"
@onready var tile_map_frames: TileMapLayer = $"TileMap Frames"
@onready var tile_map_units: TileMapLayer = $"TileMap Units"
@onready var tile_map_unit_selection: TileMapLayer = $"TileMap Unit Selection"

@onready var islands: Node = $Islands

var empire: Empire= Empire.new()

var ai_units: Array[UnitInstance]
var all_units: Array[UnitInstance]
var tile_to_unit: Dictionary

var terrain_index_lookup: Dictionary



func _ready() -> void:
	if not generator: return
	
	for terrain in GameData.terrains:
		var tile_set: TileSet= tile_map_terrain.tile_set
		for i in tile_set.get_terrains_count(0):
			if terrain.terrain_set_name == tile_set.get_terrain_name(0, i):
				terrain_index_lookup[terrain]= i
				break
	
	clear_tilemaps()
	generate_chunk(Vector2i.ZERO)


func tick():
	var state: WorldState= GameData.world_state
	
	state.turns+= 1

	empire.tick(self)

	for unit in all_units:
		unit.reset_moves()


func generate_chunk(chunk_coords: Vector2i):
	var world_offset: Vector2i= chunk_coords * chunk_size

	for x in chunk_size:
		for y in chunk_size:
			var world_coords: Vector2i= Vector2i(x, y) + world_offset
			var terrain: Terrain= generator.get_terrain(world_coords)
			tile_map_terrain.set_cells_terrain_connect([world_coords], 0, terrain_index_lookup[terrain], false)
			#tile_map_terrain.set_cell(world_coords, 0, Vector2i.ZERO)


func spawn_building(building: Building, tile: Vector2i):
	tile_map_buildings.set_cell(tile, 0, building.atlas_coords)
	tile_map_building_levels.set_cell(tile, 0, Vector2i.ZERO)


func draw_ghost_building(tile: Vector2i, building: Building):
	tile_map_buildings_ghost.clear()
	tile_map_buildings_ghost.set_cell(tile, 0, building.atlas_coords)


func settle_island(town_center_pos: Vector2i)-> IslandInstance:
	var island_definition= Island.new(true)
	var island_instance= IslandInstance.new()
	island_instance.definition= island_definition
	island_instance.world= self
	islands.add_child(island_instance)
	return island_instance


func set_building_ghost_layer_valid(flag: bool):
	tile_map_buildings_ghost.modulate.g= 1.0 if flag else 0.0
	tile_map_buildings_ghost.modulate.b= 1.0 if flag else 0.0


func spawn_unit(type: Unit, tile: Vector2i, player_unit: bool= true)-> UnitInstance:
	var unit:= UnitInstance.new(type, tile, player_unit, self)
	if player_unit:
		empire.units.append(unit)
	else:
		ai_units.append(unit)
	all_units.append(unit)
	
	update_unit_pos(unit, tile)
	return unit


func update_unit_pos(unit: UnitInstance, tile: Vector2i, previous_tile: Vector2i= Vector2i.ZERO, remove_previous: bool= false):
	tile_map_units.set_cell(tile, 0, unit.get_atlas_coords())
	tile_to_unit[tile]= unit
	if remove_previous:
		tile_map_units.set_cell(previous_tile, -1, Vector2i.ZERO)
		tile_to_unit[previous_tile]= null


func set_unit_selection_box(tile: Vector2i):
	reset_unit_selection_boxes()
	tile_map_unit_selection.set_cell(tile, 0, Vector2i.ZERO)


func reset_unit_selection_boxes():
	tile_map_unit_selection.clear()


func clear_tilemaps():
	tile_map_terrain.clear()
	tile_map_terrain_features.clear()
	tile_map_units.clear()


func get_tile(global_pos: Vector2)-> Vector2i:
	return tile_map_terrain.local_to_map(tile_map_terrain.to_local(global_pos))


func get_mouse_tile()-> Vector2i:
	return get_tile(tile_map_terrain.get_global_mouse_position())


func get_building_stat(stat: Building.Stat, tile: Vector2i)-> int:
	var atlas_coords: Vector2i= tile_map_buildings.get_cell_atlas_coords(tile)
	assert(GameData.building_atlas_lookup.has(atlas_coords))
	var building: Building= GameData.building_atlas_lookup[atlas_coords]
	var level: int= tile_map_building_levels.get_cell_source_id(tile)
	assert(level >= 0, str(tile_map_building_levels.get_used_cells()))
	return building.get_stat(stat, level, tile, self, get_island(tile))


func has_building(tile: Vector2i)-> bool:
	return get_building(tile) != null


func get_building(tile: Vector2i)-> Building:
	var coords: Vector2i= tile_map_buildings.get_cell_atlas_coords(tile)
	if not GameData.building_atlas_lookup.has(coords): return null
	return GameData.building_atlas_lookup[coords]

	
func get_building_level(tile: Vector2i)-> int:
	return tile_map_buildings.get_cell_source_id(tile)


func get_town_center_radius(tile: Vector2i)-> int:
	assert(get_building(tile) and get_building(tile).is_town_center())
	var town_center: TownCenter= get_building(tile)
	var level: int= get_building_level(tile)
	return town_center.radii[level]


func get_terrain(tile: Vector2i)-> Terrain:
	var tile_data: TileData= tile_map_terrain.get_cell_tile_data(tile)
	if tile_data == null or tile_data.terrain_set == -1 or tile_data.terrain == -1:
		return null
		
	var terrain_name: String= tile_map_terrain.tile_set.get_terrain_name(0, tile_data.terrain) if tile_data else ""
	if terrain_name.is_empty():
		return null
	return GameData.terrain_set_lookup[terrain_name]


func get_feature(tile: Vector2i)-> TerrainFeature:
	var coords: Vector2i= tile_map_terrain_features.get_cell_atlas_coords(tile)
	if not GameData.terrain_feature_atlas_lookup.has(coords): return null
	return GameData.terrain_feature_atlas_lookup[coords]


func get_island(tile: Vector2i)-> IslandInstance:
	for island in get_islands():
		if island.definition.bounding_box.has_point(tile):
			return island
	return null


func get_islands()-> Array[IslandInstance]:
	var result: Array[IslandInstance]
	result.assign(islands.get_children())
	return result


func get_neighbor_buildings(tile: Vector2i, whitelist: Array[Building]= [])-> Array[Vector2i]:
	var result: Array[Vector2i]
	for neighbor in tile_map_buildings.get_surrounding_cells(tile):
		var building: Building= get_building(neighbor)
		if building:
			if whitelist.is_empty() or building in whitelist:
				result.append(neighbor)
	return result


func get_neighbor_terrains(tile: Vector2i, whitelist: Array[Terrain]= [])-> Array[Vector2i]:
	var result: Array[Vector2i]
	for neighbor in tile_map_terrain.get_surrounding_cells(tile):
		var terrain: Terrain= get_terrain(neighbor)
		if terrain:
			if whitelist.is_empty() or terrain in whitelist:
				result.append(neighbor)
	return result


func get_neighbor_features(tile: Vector2i, whitelist: Array[TerrainFeature]= [])-> Array[Vector2i]:
	var result: Array[Vector2i]
	for neighbor in tile_map_terrain_features.get_surrounding_cells(tile):
		var feature: TerrainFeature= get_feature(neighbor)
		if feature:
			if whitelist.is_empty() or feature in whitelist:
				result.append(neighbor)
	return result


func get_unit(tile: Vector2i)-> UnitInstance:
	if tile_to_unit.has(tile):
		return tile_to_unit[tile]
	return null


func get_global_pos(tile: Vector2i)-> Vector2:
	return tile_map_terrain.to_global(tile_map_terrain.map_to_local(tile))


func is_tile_occupied(tile: Vector2i)-> bool:
	return tile_map_units.get_cell_source_id(tile) > -1
