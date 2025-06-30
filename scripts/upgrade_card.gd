extends TextureButton

@onready var text_label: RichTextLabel = $Text
var multiplier
var stat
var text
@onready var start_scale = scale
signal upgraded_chosen

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
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	tween.tween_property(self, "scale", start_scale + Vector2(0.2, 0.2), 0.2)

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	tween.tween_property(self, "scale", start_scale, 0.2)

func _on_pressed() -> void:
	emit_signal("upgraded_chosen")
