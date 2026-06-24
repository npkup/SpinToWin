extends RigidBody3D


func _on_destructible_object_destroyed() -> void:
	$AnimationPlayer.play("explosion")
	await get_tree().create_timer(3).timeout
	queue_free()
