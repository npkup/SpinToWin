extends Panel

func _ready() -> void:
	await Global.game_over
	$"../AnimationPlayer".play("gameover")
	await $Retry.pressed
	$"../AnimationPlayer".play("RESET")
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
