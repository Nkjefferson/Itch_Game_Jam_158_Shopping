extends Card

@export var enemies_to_pierce = 3

var bodies_encountered : Array[CharacterBody2D]

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		if !bodies_encountered.has(body):
			body.take_damage(self)
			enemies_to_pierce -= 1
			# Level the audio based on distance from player on impact
			MusicManager.play_sound_effect(enemy_hit_sound,-abs((global_position-parent_object.global_position).length())/25)
			if enemies_to_pierce <= 0:
				queue_free()
		bodies_encountered.append(body)
	else:
		MusicManager.play_sound_effect(wall_hit_sound,-abs((global_position-parent_object.global_position).length())/25)
		queue_free()
