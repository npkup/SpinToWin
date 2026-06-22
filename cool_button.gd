class_name Cool_Button extends Button

@export var size_increase_factor : float = 1.1
@export var size_increase_duration : float = 0.2
@export var size_increase_ease_type : Tween.EaseType
@export var size_decrease_duration : float = 0.2
@export var size_decrease_ease_type : Tween.EaseType

func _ready() -> void:
	offset_transform_enabled = true
	offset_transform_pivot_ratio = Vector2(0.5, 0.5)
	
	mouse_entered.connect(_on_mouse_hover)
	mouse_exited.connect(_on_mouse_unhover)


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
