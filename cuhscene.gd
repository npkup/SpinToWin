extends Node3D

func _ready() -> void:
	await get_tree().create_timer(13.3).timeout
	get_tree().change_scene_to_file("res://main.tscn")
