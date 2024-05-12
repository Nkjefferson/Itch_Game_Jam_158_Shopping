class_name Consumable
extends Area2D

@export var interact_sound : Resource
@export var consumable_z_index : int = 1

func spawn(pos, _val):
	position = pos
	self.z_index = consumable_z_index

func _on_body_entered(body):
	if body.is_in_group("player"):
		self.do_the_thing(body)
		if interact_sound:
			MusicManager.play_sound_effect(interact_sound)
		else:
			printerr("No interactive SFX found in: ",self.name)
		self.queue_free()
		
func do_the_thing(body):
	pass
