extends Enemy


func _process(delta):
	super.move_to_player(delta)
	check_collision()