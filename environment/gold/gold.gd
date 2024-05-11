extends Area2D

var gold_value = 1

func spawn(pos, val):
	position = pos
	gold_value = val
	self.z_index = 1


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.get_node("Inventory").add_gold(gold_value)
		self.queue_free()
