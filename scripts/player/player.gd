extends CharacterBody2D
class_name Player

@onready var health_bar: ProgressBar = $"Health Bar"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal updated_stat

@export var stats = {
	"health" : 100,
	"damage" : 34,
	"bullet_speed" : 50,
	"attack_cd" : 2.0,
	"movement_speed" : 30.0
}

func _ready() -> void:
	update_health()

func _physics_process(delta: float) -> void:
	move_and_slide()
	

func _process(delta: float) -> void:
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	
	if direction.x > 0:
		animated_sprite_2d.scale.x = 1
	elif direction.x < 0:
		animated_sprite_2d.scale.x = -1

func apply_stat_change(stat_name : String, multiplier : float):
	emit_signal("updated_stat")
	if stats.has(stat_name):
		stats[stat_name] *= multiplier
		
func update_health():
	health_bar.value = stats["health"]

func take_damage(amount):
	stats["health"] -= amount
	update_health()
