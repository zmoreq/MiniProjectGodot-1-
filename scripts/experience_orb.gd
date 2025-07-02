extends Node2D

var exp_value

@onready var game_node = get_tree().get_root().get_node("Game")
@onready var player = game_node.get_node("Player")
@onready var level_manager: Node2D = game_node.get_node("Level Manager")
signal exp_collected(exp_value)
var can_move = false

func _ready() -> void:
	level_manager.connect("orbs_can_move", self._on_wave_finished) 

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if can_move:
		position = position.move_toward(player.position, 100 * delta)

func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		emit_signal("exp_collected", exp_value)
		self.queue_free()

func _on_wave_finished():
	can_move = true
