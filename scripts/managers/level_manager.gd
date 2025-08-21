extends Node

const UPGRADES_SCREEN = preload("res://scenes/upgrades_screen.tscn")
const EXP_ORB = preload("res://scenes/experience_orb.tscn")

@onready var game_node = get_tree().get_root().get_node("Game")
@onready var orbs_container = game_node.get_node("Exp Orbs")
@onready var enemy_manager = game_node.get_node("Enemy Manager")
@onready var level_text: RichTextLabel = game_node.get_node("UI").get_node("Level Text")
@onready var player : CharacterBody2D = game_node.get_node("Player")
@onready var level_timer: Timer = $"Level Timer"

var experience = 0
var max_experience = 100
@export var max_experience_levels = {
	1 : 40,
	2 : 80,
	3 : 100,
	4 : 100,
	5 : 100,
	6 : 100,
	7 : 100,
	8 : 100,
	9 : 100,
	10 : 140,
	11 : 180,
	12 : 200,
	13 : 1000
}
var level = 1
var is_all_done = false
@onready var experience_bar: TextureProgressBar = $"../UI/Experience Bar"

signal orbs_can_move
signal lvled_up
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_manager.connect("wave_finished", self._on_wave_finished) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_all_done:
		enemy_manager.next_wave()
		is_all_done = false
		level_timer.stop()

func update_exp(value):
	experience_bar.value += float(value) / float(max_experience_levels[level]) * float(experience_bar.max_value)
	experience += value
	
	if experience >= max_experience_levels[level]:
		level_up()

func _on_enemy_died(position: Vector2, exp_value):
	var exp_orb = EXP_ORB.instantiate()
	orbs_container.add_child(exp_orb)
	exp_orb.exp_value = exp_value
	exp_orb.global_position = position
	
	exp_orb.connect("exp_collected", self._on_orb_collected)
	
func _on_orb_collected(exp_value):
	update_exp(exp_value)
	
func _on_wave_finished():
	emit_signal("orbs_can_move")
	level_timer.start()
	
func level_up():
	get_tree().paused = true
	level += 1
	level_text.text = "Level: " + str(level)
	experience_bar.value = 0
	experience = 0
	emit_signal("lvled_up")
	show_upgrades()

func show_upgrades():
	var upgrades = UPGRADES_SCREEN.instantiate()
	game_node.add_child(upgrades)
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	for upgrade in upgrades.get_children():
		tween.tween_property(upgrade, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)
		if upgrade is TextureButton:
			upgrade.connect("upgrade_chosen", self.unpause)
			upgrade.connect("add_stat", self._add_stat)

func unpause(upgrade_screen):
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	var upgrades = upgrade_screen.get_children()
	upgrades.reverse()
	for upgrade in upgrades:
		tween.tween_property(upgrade, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.2)
	await tween.finished
	get_tree().paused = false
	upgrade_screen.queue_free()

func _add_stat(stat_name, multiplier):
	player.apply_stat_change(stat_name, multiplier)
	
func _on_level_timer_timeout() -> void:
	is_all_done = true # Replace with function body.
