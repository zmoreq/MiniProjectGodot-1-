extends Node

const ENEMY_SCENE = preload("res://scenes/red_enemy.tscn")
@onready var game_node = get_tree().get_root().get_node("Game")
@onready var enemy_container = game_node.get_node("Enemies")
var max_y
var max_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_enemy():
	var enemy = ENEMY_SCENE.instantiate()
	enemy_container.add_child(enemy)
	var x = randi_range(0, max_x)
	var y = randi_range(0, max_y)
	enemy.global_position = Vector2(x, y)
	enemy.exp_value = 10
	
	enemy.connect("died", LevelManager._on_enemy_died)
