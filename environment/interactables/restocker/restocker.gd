extends Interactable


func interact():
	player_body.get_node("Inventory").restock()
