extends RigidBody3D


func _on_destructible_object_destroyed() -> void:
	$GPUParticles3D.emitting = true
	$MeshInstance3D.queue_free()
	await get_tree().create_timer(1).timeout
	queue_free()
