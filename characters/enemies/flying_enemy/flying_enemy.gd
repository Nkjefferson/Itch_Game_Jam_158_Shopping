extends Enemy

func _ready():
	super._ready()
	health = 10

func _process(delta):
	super.move_to_player(delta)
	check_collision()
