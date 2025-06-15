extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.experience_bar = $"UI/Experience Bar"
	EnemyManager.max_x = 250
	EnemyManager.max_y = 160

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
