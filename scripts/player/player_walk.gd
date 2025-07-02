extends State
class_name PlayerWalk

@export var player: CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var is_connected = false
var movementSpeed : float

func Enter():
	animated_sprite_2d.play("Walk")
	if not is_connected:
		player.connect("updated_stat", self._update_stat)
		is_connected = true
	_update_stat()
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	var direction := Input.get_vector("move_left","move_right","move_up","move_down").normalized()
	
	player.velocity = direction * movementSpeed
	
	if !direction:
		Change_State("Idle")

func Exit():
	pass

func Change_State(state_name: String):
	Transitioned.emit(self, state_name)

func _update_stat():
	movementSpeed = player.stats["movement_speed"]
