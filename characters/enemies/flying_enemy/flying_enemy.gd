extends Enemy

func _ready():
	super._ready()

func _process(delta):
	super.move_to_player(delta)
	check_collision()
