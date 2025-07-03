extends Control

@onready var play_button: TextureButton = $"VBoxContainer/Play Button"
@onready var exit_button: TextureButton = $"VBoxContainer/Exit Button"

var start_scale = Vector2(1.0, 1.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_mouse_entered() -> void:
	hover_effect_up(play_button) # Replace with function body.

func _on_exit_button_mouse_entered() -> void:
	hover_effect_up(exit_button) # Replace with function body.

func hover_effect_up(button : TextureButton):
	var tween = get_tree().create_tween()
	tween.tween_property(button, "scale", start_scale + Vector2(0.05,0.05), 0.1)

func hover_effect_down(button : TextureButton):
	var tween = get_tree().create_tween()
	tween.tween_property(button, "scale", start_scale - Vector2(0.05,0.05), 0.1)


func _on_play_button_mouse_exited() -> void:
	hover_effect_down(play_button) # Replace with function body.


func _on_exit_button_mouse_exited() -> void:
	hover_effect_down(exit_button) # Replace with function body.


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
