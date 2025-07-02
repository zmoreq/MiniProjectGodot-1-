extends Node2D

var bullet_speed : int
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var isAlive = true
var damage: int
var is_connected = false

func _ready() -> void:
	if not is_connected:
		player.connect("updated_stat", self._update_stat)
		is_connected = true
	_update_stat()

func _physics_process(delta: float) -> void:
	if isAlive:
		position += transform.x * bullet_speed * delta

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		isAlive = false
		animated_sprite_2d.play("poof")
		if body.has_method("take_damage"):
			body.take_damage(damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "poof":
		self.queue_free()

func _update_stat():
	damage = player.stats["damage"]
	bullet_speed = player.stats["bullet_speed"]
