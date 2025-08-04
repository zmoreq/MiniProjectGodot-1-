extends State
class_name EnemySpawn

@export var enemy: CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var movement_speed := 15
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func Enter():
	animated_sprite_2d.play("Spawn")
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass

func Exit():
	pass

func Change_State(state_name: String):
	Transitioned.emit(self, state_name)
