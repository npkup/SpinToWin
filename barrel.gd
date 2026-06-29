extends RigidBody3D

@export var is_for_shader_fix : bool = false

func _ready() -> void:
	$Barrel.visible = !is_for_shader_fix
	if is_for_shader_fix:
		$GPUParticles3D.emitting = true
		$GPUParticles3D2.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_destructible_object_destroyed() -> void:
	$AnimationPlayer.play("explosion")
	await get_tree().create_timer(3).timeout
	queue_free()
