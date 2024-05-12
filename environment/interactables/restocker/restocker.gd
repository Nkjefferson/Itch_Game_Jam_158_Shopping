extends Interactable

func interact():
	super()
	player_body.get_node("Inventory").restock(0)
	if interact_sound:
		MusicManager.play_sound_effect(interact_sound, 20)
	else:
		printerr("No interactive SFX found in: ",self.name)
