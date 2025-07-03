extends CharacterBody2D

@export var health := 100
@export var damage := 15
var exp_value
signal died(position, exp_value)
@onready var game_node = get_tree().get_root().get_node("Game")
@onready var player : CharacterBody2D = game_node.get_node("Player")
@onready var attack_timer: Timer = $"Attack Timer"
var can_attack = true
var player_in_range = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if can_attack and player_in_range:
		deal_damage_to_player(damage)
		can_attack = false
		attack_timer.start()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func take_damage(amount):
	health -= amount
	if health <= 0:
		call_deferred("die")

func deal_damage_to_player(damage):
	player.take_damage(damage)

func die():
	emit_signal("died", global_position, exp_value)
	self.queue_free()
	
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false

func _on_attack_timer_timeout() -> void:
	can_attack = true
