extends Node2D

@export var bullet_speed := 50
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var isAlive = true
var damage: int

func _ready() -> void:
	damage = player.damage

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
