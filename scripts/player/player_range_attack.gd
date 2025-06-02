extends State
class_name PlayerRangeAttack

@export var player: CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite_2d.play("Shoot")
	
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	
	if !direction:
		Change_State("idle")

func Exit():
	pass

func Change_State(state_name: String):
	Transitioned.emit(self, state_name)
