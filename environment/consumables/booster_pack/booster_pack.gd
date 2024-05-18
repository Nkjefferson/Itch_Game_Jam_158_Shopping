extends Consumable
var restock_num : int;

func apply_effect(body):
	restock_num = randi_range(1,4)
	body.get_node("Inventory").restock(restock_num)
