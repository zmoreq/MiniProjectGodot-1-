extends CharacterBody2D

@export var health := 100
var exp_value
signal died(position, exp_value)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		call_deferred("die")

func die():
	emit_signal("died", global_position, exp_value)
	self.queue_free()
	
