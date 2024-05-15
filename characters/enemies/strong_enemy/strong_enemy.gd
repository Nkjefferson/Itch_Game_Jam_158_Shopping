extends Enemy


func _physics_process(delta):
	super.move_to_player(delta)
	check_collision()
