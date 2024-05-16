extends Card

var degree_change = 500.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity:
		var change_in_degree = deg_to_rad(degree_change) * delta
		velocity = velocity.rotated(change_in_degree)
		position += velocity * delta
		position += ((-global_position + parent_object.global_position) * delta)
		position += parent_object.velocity * delta
