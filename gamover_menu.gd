extends Panel

func _ready() -> void:
	await Global.game_over
	$Label2.text = "You destroyed $" + str(Global.total_destruction) + " worth of property"
	if Global.total_destruction > 200:
		$Label2.text += " (You monster!)"
	$"../AnimationPlayer".play("gameover")
	await $Retry.pressed
	Global.total_destruction = 0
	$"../AnimationPlayer".play("RESET")
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
