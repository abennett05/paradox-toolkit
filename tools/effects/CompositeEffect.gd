class_name CompositeEffect
extends Effect

# Properties
@export var steps: Array[EffectStep]

func _play(context: EffectContext) -> void:
	if context.actor == null or not context.actor.is_inside_tree():
		push_warning("CompositeEffect '%s' needs a valid actor in the tree" % id)
		return
	
	var tree := context.actor.get_tree()
	
	for i in steps.size():
		var step := steps[i]
		if step == null or step.effect == null:
			continue
		
		if step.delay > 0.0:
			await tree.create_timer(step.delay).timeout
			if not is_instance_valid(context.actor):
				return
		
		# Block on this step if the next one needs to wait for this one
		var next := steps[i + 1] if i + 1 < steps.size() else null
		if next != null and next.wait_for_previous:
			await step.effect.play(context)
			if not is_instance_valid(context.actor):
				return
		else:
			step.effect.play(context)
