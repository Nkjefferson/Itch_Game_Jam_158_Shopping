extends Consumable

func do_the_thing(body):
	body.get_child("$Inventory").restock(1)
