class_name TerrainFeature
extends NamedResource

@export var atlas_coords: Vector2i
@export var base_production: int
@export var remove_cost: int
@export var destroy_on_neighbor_construction: bool= false
@export var required_remove_technology: TechnologyLevel
@export var occurrence: OccurrenceChance
