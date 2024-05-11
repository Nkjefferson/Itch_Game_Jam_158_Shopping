extends Interactable

func interact():
	player_body.get_node("Inventory").restock(1)
	player_body.get_node("Inventory").restock(2)
	player_body.get_node("Inventory").restock(3)
