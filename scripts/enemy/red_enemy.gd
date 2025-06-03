extends CharacterBody2D

@export var health := 100

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if health <= 0:
		self.queue_free()
	

func _physics_process(delta: float) -> void:
	move_and_slide()

func take_damage(damage):
	health -= damage
