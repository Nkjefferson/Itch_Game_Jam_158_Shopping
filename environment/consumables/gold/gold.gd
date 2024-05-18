extends Consumable

var gold_value = 1

func spawn(pos, val):
	super(pos, val)
	gold_value = val

func apply_effect(body):
	body.get_node("Inventory").add_gold(gold_value)

