extends Control
class_name PuzzleWindow

@onready var borders: Panel = $Borders

func _ready() -> void:
	var target_size = get_viewport().get_visible_rect().size / 3
	borders.size = target_size
	borders.position -= target_size/2 

func _process(delta: float) -> void:
	pass

func get_window_size()->Vector2:
	return borders.size
