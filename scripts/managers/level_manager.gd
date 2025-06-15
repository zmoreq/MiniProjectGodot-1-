extends Node

const EXP_ORB = preload("res://scenes/experience_orb.tscn")
@onready var game_node = get_tree().get_root().get_node("Game")
@onready var orbs_container = game_node.get_node("Exp Orbs")
var experience_bar: TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_exp(value):
	experience_bar.value += value

func _on_enemy_died(position: Vector2, exp_value):
	var exp_orb = EXP_ORB.instantiate()
	orbs_container.add_child(exp_orb)
	exp_orb.exp_value = exp_value
	exp_orb.global_position = position
	
	exp_orb.connect("exp_collected", self._on_orb_collected)
	
func _on_orb_collected(exp_value):
	print("Zebralem orba ", exp_value)
	update_exp(exp_value)
