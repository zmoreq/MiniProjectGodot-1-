extends Node

@onready var game_node = get_tree().get_root().get_node("Game")
@onready var enemy_container = game_node.get_node("Enemies")
@onready var wave_timer: Timer = $"Wave Timer"
@onready var current_wave = 1
@onready var level_manager: Node2D = $"../Level Manager"
@export var enabled : bool = true

const BOSS = preload("res://scenes/enemy_boss.tscn")

var current_enemy_count = 0
var wave_is_alive = true
var wave_finished_emitted := false
var all_enemies_died : bool = false
signal wave_finished()

var max_y
var max_x

enum EnemyType {
	RED,
	BLUE
}

@export var max_wave = 4
var waves = {
	1 : {"enemy_count": 8, "spawn_rate": 2, "hp_multi": 1},
	2 : {"enemy_count": 12, "spawn_rate": 2, "hp_multi": 1},
	3 : {"enemy_count": 16, "spawn_rate": 2, "hp_multi": 1},
	4 : {"enemy_count": 20, "spawn_rate": 2, "hp_multi": 1},
	5 : {"enemy_count": 1, "spawn_rate": 6, "hp_multi": 1}
}

const ENEMY_SCENES = {
	EnemyType.RED: preload("res://scenes/red_enemy.tscn"),
	EnemyType.BLUE: preload("res://scenes/blue_enemy.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		var spawn_rate = waves[current_wave]["spawn_rate"]
		wave_timer.wait_time = spawn_rate
		wave_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy_count = waves[current_wave]["enemy_count"]
	if current_enemy_count >= enemy_count:
		if wave_is_alive:
			wave_timer.stop()
		if !enemies_alive() and !wave_finished_emitted:
			emit_signal("wave_finished")
			current_enemy_count = 0
			wave_finished_emitted = true
	

func spawn_enemy():	
	var random_type = EnemyType.values()[randi_range(0, EnemyType.size() - 1)]
	var enemy_scene = ENEMY_SCENES.values()[random_type]
	var enemy = enemy_scene.instantiate()
	enemy_container.add_child(enemy)
	
	var x = randi_range(0, max_x)
	var y = randi_range(0, max_y)
	enemy.global_position = Vector2(x, y)
	enemy.exp_value = 20
	
	enemy.connect("died", level_manager._on_enemy_died)
	current_enemy_count += 1

func next_wave():
	if current_wave >= max_wave:
			all_enemies_died = true
			
	if !all_enemies_died:
		current_wave += 1
		game_node.fade_in_screen_with_text("WAVE " + str(current_wave), Color(0,0,0))
		var spawn_rate = waves[current_wave]["spawn_rate"]
		wave_timer.wait_time = spawn_rate
		wave_timer.start()
		wave_is_alive = true
		wave_finished_emitted = false
		
	elif all_enemies_died:
		game_node.fade_in_screen_with_text("BOSS FIGHT!!!", Color(0,0.2,0), Callable(self, "_spawn_boss"))

func _on_wave_timer_timeout() -> void:
	spawn_enemy() # Replace with function body.
	
func _spawn_boss():
	var boss = BOSS.instantiate()
	enemy_container.add_child(boss)
	boss.global_position = Vector2(130, 82) #centre of the map
	game_node.fade_out_screen()
	
func enemies_alive() -> bool:
	var enemies = enemy_container.get_children()
	
	if enemies.size() == 0:
		return false
	else:
		return true
