class_name Destructible_Object extends Area3D

@export var object : RigidBody3D
@export var knockback : float = 10
@export var destructible_sound : AudioStream
@export var destructible_sound2 : AudioStream
@export var cost : int
@onready var audio : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
@onready var audio_2 : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
var object_destroyed : bool = false

signal destroyed

func _ready() -> void:
	add_child(audio)
	add_child(audio_2)
	audio.stream = destructible_sound
	audio_2.stream = destructible_sound2
	audio.reparent(self, false)
	audio_2.reparent(self, false)
	audio.position = Vector3.ZERO
	audio_2.position = Vector3.ZERO
	audio_2.volume_db = -15
	object.lock_rotation = true
	body_entered.connect(_explode.bind())

func _explode(body : Node3D) -> void:
	if body is Player and !object_destroyed:
		Global.total_destruction += cost
		destroyed.emit()
		audio.play()
		audio_2.play()
		object.lock_rotation = false
		object.linear_velocity = -object.global_transform.origin.direction_to(body.global_position) * knockback
		object_destroyed = true
