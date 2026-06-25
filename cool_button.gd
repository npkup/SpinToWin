class_name Cool_Button extends Button

@export var size_increase_factor : float = 1.1
@export var size_increase_duration : float = 0.2
@export var size_increase_ease_type : Tween.EaseType
@export var size_decrease_duration : float = 0.2
@export var size_decrease_ease_type : Tween.EaseType

@export var press_sound : AudioStream
@export var press_sound_volume_db : float = 0
var press_sound_player : AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	offset_transform_enabled = true
	pivot_offset_ratio = Vector2(0.5, 0.5)
	
	mouse_entered.connect(_on_mouse_hover)
	mouse_exited.connect(_on_mouse_unhover)
	pressed.connect(press_sound_player.play)
	
	press_sound_player.stream = press_sound
	press_sound_player.volume_db = press_sound_volume_db
	add_child(press_sound_player)


func _on_mouse_hover() -> void:
	var hover_tween : Tween = create_tween()
	hover_tween.set_ease(size_increase_ease_type)
	hover_tween.tween_property(self, "scale", Vector2(size_increase_factor, size_increase_factor), size_increase_duration)
	hover_tween.play()

func _on_mouse_unhover() -> void:
	var hover_tween : Tween = create_tween()
	hover_tween.set_ease(size_decrease_ease_type)
	hover_tween.tween_property(self, "scale", Vector2(1, 1), size_decrease_duration)
	hover_tween.play()
