extends CharacterBody2D
class_name MiniBoss

@onready var health_bar: ProgressBar = $"Health Bar"
@onready var game_node = get_tree().get_root().get_node("Game")
@onready var player : CharacterBody2D = game_node.get_node("Player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var attack_area: Area2D = $"Attack Area"
@onready var global_cooldown_timer: Timer = $"Global Cooldown Timer"
@onready var attack_1_timer: Timer = $"Attack Area/Attack 1 Timer"
@onready var cast_bar: ProgressBar = $"Cast Bar"

signal boss_died

@export var stats = {
	"health" : 500.0,
	"damage" : 30.0,
	"max_health" : 500.0
}

var rotation_to_player
var is_alive : bool = true
var swap_attack : bool = false
var player_in_area : bool = false

func _ready() -> void:
	update_health()

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	if attack_1_timer.time_left > 0:
		cast_bar.value = (attack_1_timer.wait_time - attack_1_timer.time_left) / attack_1_timer.wait_time * cast_bar.max_value 
	else:
		cast_bar.value = 0
func update_health():
	health_bar.value = stats["health"] * health_bar.max_value / stats["max_health"]
	if stats["health"] <= 0:
		die()

func take_damage(amount):
	stats["health"] -= amount
	update_health()

func _cast_area_attack():
	var direction_to_player = player.global_position - global_position
	rotation_to_player = direction_to_player.angle()
	attack_area.rotation = rotation_to_player
	attack_1_timer.start()
	
func die():
	is_alive = false
	emit_signal("boss_died")


func _on_global_cooldown_timer_timeout() -> void:
	if !swap_attack:
		_cast_area_attack()
	elif swap_attack:
		pass


func _on_attack_1_timer_timeout() -> void:
	if player_in_area:
		player.take_damage(stats["damage"])
	attack_1_timer.stop()
	#swap_attack = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	player_in_area = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	player_in_area = false
