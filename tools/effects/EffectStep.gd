class_name EffectStep
extends Resource

@export var effect: Effect
@export var delay: float = 0.0	# Seconds to wait before starting this step
@export var wait_for_previous: bool = false # Wait for previous step to finish?
