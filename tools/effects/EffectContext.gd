class_name EffectContext
extends RefCounted

var actor: Node
var position: Vector3
var normal := Vector3.UP
var intensity := 1.0

static func for_actor(new_actor: Node) -> EffectContext:
	var ctx := EffectContext.new()
	ctx.actor = new_actor
	var actor_3d := new_actor as Node3D
	if actor_3d != null:
		ctx.position = actor_3d.global_position
	return ctx
