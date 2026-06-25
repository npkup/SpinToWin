extends CharacterBody3D

@export var target : CharacterBody3D
@export var enabled : bool = true:
	set(value):
		if value:
			$AudioStreamPlayer3D.play()
		else:
			$AudioStreamPlayer3D.stop()
		enabled = value
var chasing : bool = true

func _physics_process(_delta: float) -> void:
	if enabled:
		$AnimationPlayer.play("walk")
		var direction : Vector3 = global_position.direction_to(target.global_position)
		var distance_multiplier : float = global_position.distance_to(target.global_position)
		distance_multiplier /= 10
		distance_multiplier = clamp(distance_multiplier, 1, 5)
		direction.y = 0
		
		direction.normalized()
		if chasing:
			velocity = direction * 5 * distance_multiplier
		else:
			velocity = Vector3.ZERO
		$AnimationPlayer.speed_scale = Vector3(0, 0, 0).distance_to(velocity) / 2
		var direction_facing := global_transform.origin.direction_to(target.global_position)
		direction_facing.y = 0
		look_at(global_position - direction)
		move_and_slide()
	else:
		$AnimationPlayer.pause()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player and enabled:
		chasing = false
		enabled = false
		body.sawblade.rotation_speed = 0
		body.enabled = false
		body.target_global_transform = $Marker3D.global_transform
		$AnimationPlayer.stop()
		await get_tree().create_timer(1).timeout
		Global.game_over.emit()
