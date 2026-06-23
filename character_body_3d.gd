class_name Player extends CharacterBody3D

var last_direction : int = 1
var rotational_velocity : float = 0
@export var sawblade : SawBlade
var enabled : bool = true
var target_global_transform : Transform3D

func _physics_process(delta: float) -> void:
	var move_speed : float = $sawblade.rotation_speed * 2*PI * ((1.0/8.0) / 2.5)
	$"../Speed".text = "Speed = " + str(move_speed)
	if enabled:
		$sawblade.rotation_speed -= delta * 0.2
	else:
		global_transform = lerp(global_transform, target_global_transform, 0.1)
	$CollisionShape3D.disabled = !enabled
	if enabled:
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	
	velocity.z = move_speed * sin(rotation.y)
	velocity.x = -move_speed * cos(rotation.y)
	$RayCast3D.rotation_degrees.y = lerp($RayCast3D.rotation_degrees.y, float(20 * last_direction), 0.05)
	
	if Input.is_action_pressed("right") and enabled:
		last_direction = 1
		rotational_velocity = move_toward(rotational_velocity, -3, delta * 6)
		rotation_degrees.x = lerp(rotation_degrees.x, -20.0, 0.1)
		
	elif Input.is_action_pressed("left") and enabled:
		last_direction = -1
		rotational_velocity = move_toward(rotational_velocity, 3, delta * 6)
		rotation_degrees.x = lerp(rotation_degrees.x, 20.0, 0.1)
	else:
		rotational_velocity = move_toward(rotational_velocity, 0, delta * 6)
		rotation_degrees.x = lerp(rotation_degrees.x, 0.0, 0.1)
	$RayCast3D/Camera3D.global_rotation.z = 0
	rotate(Vector3(0, 1, 0), rotational_velocity * delta)
	if is_on_floor():
		velocity.y = 0
	$GPUParticles3D.emitting = (is_on_floor() and enabled)
	move_and_slide()
