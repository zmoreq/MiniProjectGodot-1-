extends CharacterBody2D
class_name MiniBoss

@onready var health_bar: ProgressBar = $"Health Bar"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal boss_died

@export var stats = {
	"health" : 500.0,
	"damage" : 30.0,
	"max_health" : 500.0
}

var is_alive : bool = true

func _ready() -> void:
	update_health()

func _physics_process(delta: float) -> void:
	if is_alive:
		move_and_slide()

func _process(delta: float) -> void:
	pass

func update_health():
	health_bar.value = stats["health"] * health_bar.max_value / stats["max_health"]
	if stats["health"] <= 0:
		die()

func take_damage(amount):
	stats["health"] -= amount
	update_health()

func die():
	is_alive = false
	emit_signal("boss_died")
