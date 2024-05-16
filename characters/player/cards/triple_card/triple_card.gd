extends Card
const DEG_OFFSET = 15

func spawn(parent, initial_velocity, target):
	super(parent, initial_velocity,target)
	
	var dup1 = self.duplicate()
	parent.get_parent().add_child(dup1)
	dup1.rotation_degrees += DEG_OFFSET
	dup1.velocity = velocity.rotated(deg_to_rad(DEG_OFFSET))
	dup1.parent_object = parent
	
	var dup2 = self.duplicate()
	parent.get_parent().add_child(dup2)
	dup2.rotation_degrees -= DEG_OFFSET
	dup2.velocity = velocity.rotated(deg_to_rad(-DEG_OFFSET))
	dup2.parent_object = parent

