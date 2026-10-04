class_name Trigger
extends Area3D

# Inspector
@export var one_shot: bool = false
@export var allowed_groups: Array[String]

# System
var _has_triggered: bool = false

# Signals
signal trigger_enter(body: Node3D)
signal trigger_exit(body: Node3D)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if one_shot and _has_triggered: return
	
	if not validate_body(body): return
	
	_has_triggered = true
	trigger_enter.emit(body)
	
	if one_shot:
		set_deferred("monitoring", false)

func _on_body_exited(body: Node3D) -> void:
	if not validate_body(body): return
	trigger_exit.emit(body)

func reset() -> void:
	_has_triggered = false
	set_deferred("monitoring", true)

# Helpers
func validate_body(body: Node3D) -> bool:
	if allowed_groups.is_empty():
		return true
	for group in allowed_groups:
		if body.is_in_group(group): return true
	return false
