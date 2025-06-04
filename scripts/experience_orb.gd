extends Node2D

var exp_value : int = 0

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("update_exp"):
			body.update_exp(exp_value)
			self.queue_free()
