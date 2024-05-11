extends Interactable

func interact():
	var player_inventory = player_body.get_node("Inventory")
	if player_inventory.check_funds(get_parent().shop_cost):
		player_inventory.restock(1)
		player_inventory.restock(2)
		player_inventory.restock(3)
		player_inventory.pay_gold(get_parent().shop_cost)
