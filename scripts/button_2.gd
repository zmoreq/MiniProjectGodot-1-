extends Button
const BLUE = preload("res://scenes/blue_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var enemy = BLUE.instantiate()
	get_tree().root.add_child(enemy)
	enemy.global_position = Vector2(0, 0)
