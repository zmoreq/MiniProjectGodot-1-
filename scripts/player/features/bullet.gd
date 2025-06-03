extends Node2D

@export var attackSpeed := 50
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var isAlive = true

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if isAlive:
		position += transform.x * attackSpeed * delta


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Enemy"):
		isAlive = false
		animated_sprite_2d.play("poof")
		body.take_damage(player.damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "poof":
		self.queue_free()
