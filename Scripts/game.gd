extends Node2D
class_name Game

var currentLevel:Level

#For the vizualisation window 
@onready var windowRes = preload("res://Scenes/Game Elements/window.tscn")
var window:PuzzleWindow
var moving_window:bool = false
var mouse_offset
var rotating_window:bool = false
var initial_rotation

#For the shader
var shader_group:CanvasGroup = CanvasGroup.new()
var shader_rect:ColorRect = ColorRect.new()

var shader_material = ShaderMaterial.new()


func _ready() -> void:
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_viewport().transparent_bg = true

	currentLevel = preload("res://Scenes/Levels/test_level.tscn").instantiate()
	add_child(shader_group)
	shader_group.add_child(currentLevel)
	
	#For the vizualisation window
	window = windowRes.instantiate()
	window.gui_input.connect(on_window_input)
	add_child(window)
	
	#For the shader 
	shader_material.shader = preload("res://Scripts/game_vizualiser.gdshader")
	shader_group.material = shader_material
	#shader_group.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().free()
		
	if window:
		var mat = shader_group.material as ShaderMaterial
		mat.set_shader_parameter("window_center",window.global_position + window.get_window_size()/2)
		mat.set_shader_parameter("window_size",window.get_window_size())
		
		#Allows us to interact with stuff behind the game (but it slows the game a lot and is not precise because of the borders of the window)    
		#DisplayServer.window_set_mouse_passthrough(make_window_array()) 
		
		if moving_window:
			window.position = get_global_mouse_position() - mouse_offset
			
		if rotating_window:
			pass
		
func on_window_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.pressed :
			match event.button_index :
				MouseButton.MOUSE_BUTTON_LEFT:
					mouse_offset = event.position 
					moving_window = true
				MouseButton.MOUSE_BUTTON_RIGHT:
					var window_center = window.global_position + window.size/2
					initial_rotation = (event.global_position - window_center).angle()
					rotating_window = true
					pass
		elif not event.pressed :
			moving_window = false
			rotating_window = false
			
func make_window_array()->PackedVector2Array:
	var array = []
	array.append(window.position + Vector2(-10,-40))
	array.append(window.position + Vector2(window.get_window_size().x + 10,-40))
	array.append(window.position + window.get_window_size() + Vector2(10,10))
	array.append(window.position + Vector2(-10,window.get_window_size().y +10))
	return array
			
