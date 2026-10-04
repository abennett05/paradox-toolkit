extends Node

@export var effect_controller: EffectController
@export var test_effect_id: String

func _unhandled_input(_event: InputEvent) -> void:
	if effect_controller == null: return
	
	if Input.is_action_just_pressed("ui_accept"):
		effect_controller.play_effect(test_effect_id)
