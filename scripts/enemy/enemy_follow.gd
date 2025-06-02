extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var movement_speed := 15
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func Enter():
	animated_sprite_2d.play("Walk")
	
	
func Update(_delta: float):
	var direction := (player.global_position - enemy.global_position).normalized()
	if direction.x > 0:
		animated_sprite_2d.scale.x = 1
	elif direction.x < 0:
		animated_sprite_2d.scale.x = -1
	enemy.velocity = direction * movement_speed

func Physics_Update(_delta: float):
	pass

func Exit():
	pass

func Change_State(state_name: String):
	Transitioned.emit(self, state_name)
