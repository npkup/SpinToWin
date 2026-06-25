extends Control

func _process(delta: float) -> void:
	var mat : StandardMaterial3D = $"SubViewportContainer/SubViewport/3D/MeshInstance3D".get_surface_override_material(0)
	var speed : float = $"SubViewportContainer/SubViewport/3D/sawblade".rotation_speed * 2*PI * ((1.0/8.0) / 2.5) * -((global_position.y / 16) + -2)
	if mat:
		mat.uv1_offset -= Vector3(speed * delta, 0, 0)


func _on_cool_button_pressed() -> void:
	$AnimationPlayer.play("start")
	await get_tree().create_timer(6).timeout
	get_tree().change_scene_to_file("res://cuhscene.tscn")
