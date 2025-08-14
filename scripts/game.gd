extends Node2D
@onready var enemy_manager: Node2D = $"Enemy Manager"
@onready var level_manager: Node2D = $"Level Manager"

var is_paused = false
var esc_menu
const pause_menu = preload("res://scenes/pause_screen.tscn")
@onready var info_text: RichTextLabel = $"UI/Info mode/RichTextLabel"
@onready var color_rect: ColorRect = $"UI/Info mode/ColorRect"

# Called when the node enters the scene tree for the first time.
func _ready():
	_game_init() #na czas testow wylaczone
	
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
	
func _close_pause_menu(menu):
	menu.queue_free()
	
func _game_init():
	get_tree().paused = true
	var tween1 = get_tree().create_tween()
	tween1.set_pause_mode(2)
	tween1.tween_property(color_rect, "color:a", 0, 4.0)
	tween1.connect("finished", self._unpause)
	
	var tween2 = get_tree().create_tween()
	tween2.set_pause_mode(2)
	tween2.tween_property(info_text, "modulate:a", 0, 4.0)
	
func _unpause():
	get_tree().paused = false
	
func _on_player_died() -> void:
	
	info_text.text = "GAME OVER"
	get_tree().paused = true
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	tween.tween_property(color_rect, "color", Color(0.2,0,0), 2.0)
	tween.tween_property(info_text, "modulate:a", 1.0, 2.0)
	tween.connect("finished", self._back_to_menu) # imo do zmiany na klaiwsz losowy jakis
	
func _back_to_menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
