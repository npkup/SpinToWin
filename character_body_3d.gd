class_name Player extends CharacterBody3D

var last_direction : int = 1
var rotational_velocity : float = 0
@export var sawblade : SawBlade
@export var enabled : bool = true
@export var captured : bool = false
var target_global_transform : Transform3D

@export var camera_lean_meters : float
@export var camera_lean_speed : float
@export var camera_rotate_speed : float

func _physics_process(delta: float) -> void:
	var move_speed : float = $sawblade.rotation_speed * 2*PI * ((1.0/8.0) / 2.5) * -((global_position.y / 16) + -2)
	$"../Speed".text = "Speed = " + str(round(move_speed * 10) / 10) + "m/s"
	$"../Control/Label2".text = "Value of property destroyed = $" + str(Global.total_destruction)
	$RayCast3D/Camera3D.fov = clamp((90 * move_speed / 10), 60, 179)
	$RayCast3D/Camera3D.fov = clamp($RayCast3D/Camera3D.fov, 60, 110)
	$RayCast3D/Camera3D.global_position.y = global_position.y + 0.75 * move_speed / 5
	if $RayCast3D.get_collider() is PhysicsBody3D:
		$RayCast3D/Camera3D.global_position = $RayCast3D.get_collision_point()
	else:
		$RayCast3D/Camera3D.position.x = 1
		$RayCast3D/Camera3D.position.y = 0.75
	if enabled:
		$sawblade.rotation_speed -= delta * 0.1
	elif captured:
		global_transform = lerp(global_transform, target_global_transform, 0.1)
	$CollisionShape3D.disabled = !enabled
	if enabled:
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	
	velocity.z = move_speed * sin(rotation.y)
	velocity.x = -move_speed * cos(rotation.y)
	$RayCast3D.rotation_degrees.y = lerp($RayCast3D.rotation_degrees.y, float(20 * last_direction), camera_rotate_speed)
	if !$RayCast3D2.is_colliding() and is_on_wall():
		global_position.y += 0.15 - 0.023
	if Input.is_action_pressed("right") and enabled:
		last_direction = 1
		rotational_velocity = move_toward(rotational_velocity, -3, delta * 6)
		$sawblade.rotation_degrees.x = lerp($sawblade.rotation_degrees.x, -20.0 + 90, 0.06)
		$RayCast3D/Camera3D.position.z = lerp($RayCast3D/Camera3D.position.z, -camera_lean_meters, camera_lean_speed) 
	elif Input.is_action_pressed("left") and enabled:
		last_direction = -1
		rotational_velocity = move_toward(rotational_velocity, 3, delta * 6)
		$sawblade.rotation_degrees.x = lerp($sawblade.rotation_degrees.x, 20.0 + 90, 0.06)
		$RayCast3D/Camera3D.position.z = lerp($RayCast3D/Camera3D.position.z, camera_lean_meters, camera_lean_speed) 
	else:
		rotational_velocity = move_toward(rotational_velocity, 0, delta * 6)
		$sawblade.rotation_degrees.x = lerp($sawblade.rotation_degrees.x, 0.0 + 90, 0.06)
		$RayCast3D/Camera3D.position.z = lerp($RayCast3D/Camera3D.position.z, 0.0, camera_lean_speed) 
	
	if Input.is_action_pressed("camera left") and enabled:
		last_direction = -1
	if Input.is_action_pressed("camera right") and enabled:
		last_direction = 1
	$RayCast3D/Camera3D.global_rotation.z = 0
	$RayCast3D/Camera3D.global_rotation_degrees.x = -12.6
	rotate(Vector3(0, 1, 0), rotational_velocity * delta)
	if is_on_floor():
		velocity.y = 0
	$GPUParticles3D.emitting = (is_on_floor() and enabled)
	$GPUParticles3D2.emitting = (is_on_floor() and enabled)
	if enabled:
		move_and_slide()
