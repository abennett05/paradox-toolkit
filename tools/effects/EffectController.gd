class_name EffectController
extends Node

# Inspector
@export var effects: Array[Effect] = []

var _lookup: Dictionary = {}	# id -> Effect
var _played: Dictionary = {}	# id -> bool

# Signals
signal effect_started(id: String)

func _ready() -> void:
	for effect in effects:
		if effect == null:
			continue
		if effect.id.is_empty():
			push_warning("EffectController on '%s' has an effect with on id." % get_parent().name)
			continue
		if _lookup.has(effect.id):
			push_warning("Duplicate effect id '%s' on '%s'." % [effect.id, get_parent().name])
			continue
		_lookup[effect.id] = effect

func has_effect(id: String) -> bool: return _lookup.has(id)

func play_effect(id: String, context: EffectContext = null) -> void:
	var effect: Effect = _lookup.get(id)
	if effect == null:
		push_warning("No effect '%s' on '%s'." % [id, get_parent().name])
		return
	
	if effect.one_shot and _played.get(id, false):
		return
	_played[id] = true
	
	if context == null:
		context = EffectContext.for_actor(get_parent())
	elif context.actor == null:
		context.actor = get_parent()
	
	effect_started.emit(id)
	effect.play(context)

func reset_effect(id: String) -> void: _played.erase(id)

func reset_all_effects() -> void: _played.clear()
