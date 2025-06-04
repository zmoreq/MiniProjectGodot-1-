extends CharacterBody2D

@export var health := 100
const EXP_ORB = preload("res://scenes/experience_orb.tscn")
@export var exp_value : int = 50

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		call_deferred("die")

func die():
	spawn_exp_orb()
	self.queue_free()
	
	
func spawn_exp_orb():
	var exp_orb = EXP_ORB.instantiate()
	get_tree().root.add_child(exp_orb)
	exp_orb.exp_value = exp_value
	exp_orb.global_position = global_position
