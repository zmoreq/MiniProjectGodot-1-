extends Node2D

@export var attackSpeed := 50

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position += transform.x * attackSpeed * delta
