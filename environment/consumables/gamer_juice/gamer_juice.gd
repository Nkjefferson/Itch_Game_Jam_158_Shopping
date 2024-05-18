extends Consumable

@export var heal_quality : int = 10

func spawn(pos, val):
	super(pos, val)
	heal_quality = val

func apply_effect(body):
	body.heal(heal_quality)
	pass
