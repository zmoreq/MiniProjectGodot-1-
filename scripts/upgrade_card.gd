extends Control

@onready var text_label: RichTextLabel = $Text
var multiplier
var stat
var text

func _ready() -> void:
	set_data()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func set_data():
	var random_choice = randi_range(1, UpgradesData.data.size() - 1)
	var data = UpgradesData.data[random_choice]
	
	text = data["text"]
	multiplier = data["multiplier"]
	stat = data["stat"]
	
	text_label.text = text + "\n" + stat + " = " + str(multiplier)


func _on_mouse_entered() -> void:
	scale = Vector2(2, 2)
