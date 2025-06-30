extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)
	for child in get_children():
		tween.tween_property(child, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_upgrade_card_upgraded_chosen() -> void:
	unpause()

func _on_upgrade_card_2_upgraded_chosen() -> void:
	unpause()

func _on_upgrade_card_3_upgraded_chosen() -> void:
	unpause()

func unpause():
	get_tree().paused = false
	self.queue_free()
