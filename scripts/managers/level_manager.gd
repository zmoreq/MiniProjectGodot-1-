extends Node

const UPGRADES_SCREEN = preload("res://scenes/upgrades_screen.tscn")
const EXP_ORB = preload("res://scenes/experience_orb.tscn")

@onready var game_node = get_tree().get_root().get_node("Game")
@onready var orbs_container = game_node.get_node("Exp Orbs")
@onready var enemy_manager = game_node.get_node("Enemy Manager")
@onready var level_text: RichTextLabel = game_node.get_node("UI").get_node("Level Text")

var experience = 0
var max_experience = 100
var level = 1
var experience_bar: TextureProgressBar

signal orbs_can_move
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_manager.connect("wave_finished", self._on_wave_finished) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_exp(value):
	experience_bar.value += value
	experience += value
	
	if experience >= max_experience:
		level_up()

func _on_enemy_died(position: Vector2, exp_value):
	var exp_orb = EXP_ORB.instantiate()
	orbs_container.add_child(exp_orb)
	exp_orb.exp_value = exp_value
	exp_orb.global_position = position
	
	exp_orb.connect("exp_collected", self._on_orb_collected)
	
func _on_orb_collected(exp_value):
	print("Zebralem orba ", exp_value)
	update_exp(exp_value)
	
func _on_wave_finished():
	print("Widze ze wave sie skonczyl!!!")
	emit_signal("orbs_can_move")
	
func level_up():
	get_tree().paused = true
	level += 1
	level_text.text = "Level: " + str(level)
	experience_bar.value = 0
	experience = 0
	
	show_upgrades()

func show_upgrades():
	var upgrades = UPGRADES_SCREEN.instantiate()
	game_node.add_child(upgrades)
	
