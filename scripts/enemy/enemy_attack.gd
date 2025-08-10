extends State
class_name EnemyAttack

@export var enemy : CharacterBody2D

func Enter():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	enemy.velocity = Vector2()

func Exit():
	pass

func Change_State(state_name: String):
	Transitioned.emit(self, state_name)
