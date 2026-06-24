extends Node3D

@warning_ignore("unused_signal")
signal game_over

var total_destruction : int = 0

func _reset_destruction() -> void:
	total_destruction = 0
