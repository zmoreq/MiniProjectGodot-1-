extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")
@export var player: CharacterBody2D
@export var timer: Timer

var is_connected = false

func _ready() -> void:
	if not is_connected:
		player.connect("updated_stat", self._update_stat)
		is_connected = true
	_update_stat()
	timer.start()

func _process(_delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("attack"):

func _on_timer_timeout():
	shoot()

func shoot():
	look_at(get_global_mouse_position())
	
	var bullet_instance = BULLET.instantiate()
	var game_node = get_tree().get_root().get_node("Game")
	var bullet_container = game_node.get_node("Bullets")
	bullet_container.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.rotation = rotation
	
func _update_stat():
	timer.wait_time = player.stats["attack_cd"]
