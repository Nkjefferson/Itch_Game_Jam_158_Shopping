extends Interactable

@export var juice_quality : int = 10

func interact():
	player_body.heal(juice_quality);
	
