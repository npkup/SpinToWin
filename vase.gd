extends RigidBody3D

@export var is_for_shader_fix : bool = false

func _ready() -> void:
	$MeshInstance3D.visible = !is_for_shader_fix
	if is_for_shader_fix:
		$GPUParticles3D.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_destructible_object_destroyed() -> void:
	$GPUParticles3D.emitting = true
	$MeshInstance3D.queue_free()
	await get_tree().create_timer(1).timeout
	queue_free()
