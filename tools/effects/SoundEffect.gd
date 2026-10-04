class_name SoundEffect
extends Effect

# Properties
@export var sound: AudioStream
@export_range(0.0, 1.0) var volume: float = 1.0
@export var pitch: float = 1.0
@export var sound_offset: float = 0.0

func _play(context: EffectContext) -> void:
	if sound == null:
		push_warning("SoundEffect '%s' has no sound assigned." % id)
		return
	
	# Set up stream player
	var player := AudioStreamPlayer.new()
	player.stream = sound
	player.pitch_scale = pitch
	player.volume_linear = volume * context.intensity
	context.actor.add_child(player)
	player.finished.connect(player.queue_free)
	player.play(sound_offset)
	await player.finished
	
