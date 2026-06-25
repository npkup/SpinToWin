extends RigidBody3D


func _on_destructible_object_destroyed() -> void:
	await get_tree().create_timer(1).timeout
	queue_free()
