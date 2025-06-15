extends Node2D

var exp_value

signal exp_collected(exp_value)

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("exp_collected", exp_value)
		self.queue_free()
