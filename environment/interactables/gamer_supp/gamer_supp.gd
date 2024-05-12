extends Interactable

@export var juice_quality : int = 10

func interact():
	var player_inventory = player_body.get_node("Inventory")
	if player_inventory.check_funds(get_parent().shop_cost):
		player_body.heal(juice_quality)
		player_inventory.pay_gold(get_parent().shop_cost)
		if interact_sound:
			MusicManager.play_sound_effect(interact_sound)
		else:
			printerr("No interactive SFX found in: ",self.name)
	
