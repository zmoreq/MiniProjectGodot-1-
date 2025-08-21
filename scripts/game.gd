extends Node2D
@onready var enemy_manager: Node2D = $"Enemy Manager"
@onready var level_manager: Node2D = $"Level Manager"

var is_paused = false
var esc_menu
const pause_menu = preload("res://scenes/pause_screen.tscn")
@onready var info_text: RichTextLabel = $"UI/Info mode/RichTextLabel"
@onready var color_rect: ColorRect = $"UI/Info mode/ColorRect"

@export var player : CharacterBody2D
@export var player_start_position : Vector2
var boss_died = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_game_init() #na czas testow wylaczone
	
	level_manager.experience_bar = $"UI/Experience Bar"
	enemy_manager.max_x = 250
	enemy_manager.max_y = 160

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if boss_died:
		fade_in_screen_with_text("YOU COMPLETED THIS DEMO!!! GZ", Color(0,0,0.2), Callable(self, "_back_to_menu"))

func _show_pause_menu():
	var menu = pause_menu.instantiate()
	esc_menu = menu
	add_child(menu)
	
func _close_pause_menu(menu):
	menu.queue_free()
	
func _game_init():
	var message = "Welcome to my first small Godot project.\nNothing fancy, but you have to start somewhere!\nEnjoy and get ready!!!"
	fade_in_screen_with_text(message, Color(0,0,0))
	
func _unpause():
	get_tree().paused = false
	
func _on_player_died() -> void:
	fade_in_screen_with_text("GAME OVER", Color(0.2,0,0), Callable(self, "_back_to_menu"))
	 # imo do zmiany na klawisz losowy jakis
	
func _back_to_menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func fade_in_screen_with_text(message : String, color : Color, callback: Callable = Callable(self, "fade_out_screen")):
	info_text.text = message
	get_tree().paused = true
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	tween.tween_property(color_rect, "color", color, 2.0)
	tween.tween_property(info_text, "modulate:a", 1.0, 2.0)
	tween.connect("finished", callback)

func fade_out_screen():
	player.global_position = player_start_position
	get_tree().paused = true
	var tween1 = get_tree().create_tween()
	tween1.set_pause_mode(2)
	tween1.tween_property(color_rect, "color:a", 0, 4.0)
	tween1.connect("finished", self._unpause)
	
	var tween2 = get_tree().create_tween()
	tween2.set_pause_mode(2)
	tween2.tween_property(info_text, "modulate:a", 0, 4.0)
