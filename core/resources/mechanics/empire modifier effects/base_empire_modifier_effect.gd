class_name BaseEmpireModifierEffect
extends NamedResource

enum Type { POPULATION, PRODUCTION, STABILITY, POLLUTION, RESEARCH, POWER }

@export var type: Type

# -1 => forever
@export var duration: int= -1
