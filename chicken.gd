extends RigidBody3D

var timer : float = 0
var next_time_turning : float = randi_range(1, 4)

func _ready() -> void:
	rotation_degrees.y = randi_range(-180, 180)

func _physics_process(delta: float) -> void:
	timer += delta
	if round(timer) == round(next_time_turning) and !$Destructible_Object.object_destroyed:
		next_time_turning += randi_range(1, 5)
		rotation_degrees.y += randi_range(-20, 20)
	
	if !$Destructible_Object.object_destroyed:
		var forward_direction : Vector3 = global_position.direction_to($Marker3D.global_position)
		forward_direction.y = 0
		linear_velocity.x = forward_direction.x
		linear_velocity.z = forward_direction.z


func _on_destructible_object_destroyed() -> void:
	$GPUParticles3D.emitting = true
	$AnimationPlayer.play("die")
	await get_tree().create_timer(3).timeout
	queue_free()
