extends CharacterBody2D
class_name Player

@export var health := 100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var damage := 50
var experience := 0


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	move_and_slide()

func _process(delta: float) -> void:
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	
	if direction.x > 0:
		animated_sprite_2d.scale.x = 1
	elif direction.x < 0:
		animated_sprite_2d.scale.x = -1
