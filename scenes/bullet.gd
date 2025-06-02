extends Node2D

@export var attackSpeed := 50
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position += transform.x * attackSpeed * delta


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body != player:
		self.queue_free()
		body.take_damage(player.damage)
