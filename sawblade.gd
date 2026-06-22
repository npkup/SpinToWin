@tool
class_name SawBlade extends Node3D

@export var rotation_speed : float

func _physics_process(delta: float) -> void:
	$Cylinder.rotate(Vector3(0, 1, 0), rotation_speed * delta)
	$Cube.rotate(Vector3(0, 1, 0), rotation_speed * delta)
