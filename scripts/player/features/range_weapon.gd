extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $"../Timer"
@export var attack_cd = 2.0

func _ready() -> void:
	timer.wait_time = attack_cd
	timer.start()

func _process(delta: float) -> void:
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
	
	
