class_name Effect
extends Resource

# Properties
@export var id : String
@export var one_shot : bool = false

func play(context: EffectContext) -> void:
	await _play(context)

func _play(_context: EffectContext) -> void: # Override in subclass
	pass
