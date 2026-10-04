class_name ParticleEffect
extends Effect

# Inspector
@export var particle: PackedScene
@export var position_offset: Vector3

func _play(context: EffectContext) -> void:
	if particle == null:
		push_warning("ParticleEffect '%s' has no particle scene assigned." % id)
		return
	
	if context.actor == null or not context.actor.is_inside_tree():
		push_warning("ParticleEffect '%s' needs a valid actor in the tree." % id)
		return
	
	var node := particle.instantiate()
	var instance := node as Node3D
	if instance == null:
		push_warning("ParticleEffect '%s' is not a 3D object." % id)
		node.queue_free()
		return
	
	context.actor.get_tree().current_scene.add_child(instance)
	instance.global_position = context.position + position_offset
	
	var particles := instance as GPUParticles3D
	if particles != null:
		particles.one_shot = true
		particles.finished.connect(instance.queue_free)
		particles.emitting = true
