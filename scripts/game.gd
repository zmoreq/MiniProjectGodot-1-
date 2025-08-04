extends Node2D
@onready var enemy_manager: Node2D = $"Enemy Manager"
@onready var level_manager: Node2D = $"Level Manager"

var is_paused = false
var esc_menu
const pause_menu = preload("res://scenes/pause_screen.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	level_manager.experience_bar = $"UI/Experience Bar"
	enemy_manager.max_x = 250
	enemy_manager.max_y = 160

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") && !is_paused:
		_show_pause_menu()
	elif Input.is_action_just_pressed("pause") && is_paused:
		_close_pause_menu(esc_menu)

func _show_pause_menu():
	var menu = pause_menu.instantiate()
	esc_menu = menu
	add_child(menu)
	get_tree().paused = true #wymaga naprawienia 
	
func _close_pause_menu(menu):
	menu.queue_free()
