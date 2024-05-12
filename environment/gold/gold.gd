extends Area2D

@export var interact_sound : Resource

var gold_value = 1

func spawn(pos, val):
	position = pos
	gold_value = val
	self.z_index = 1


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.get_node("Inventory").add_gold(gold_value)
		if interact_sound:
			MusicManager.play_sound_effect(interact_sound)
		else:
			printerr("No interactive SFX found in: ",self.name)
		self.queue_free()
