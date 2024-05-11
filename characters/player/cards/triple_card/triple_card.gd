extends Basic_Card
const DEG_OFFSET = 15

func spawn(pos, deg):
	super(pos, deg)
	
	var dup1 = self.duplicate()
	self.get_parent().add_child(dup1)
	dup1.rotation_degrees += DEG_OFFSET
	
	var dup2 = self.duplicate()
	self.get_parent().add_child(dup2)
	dup2.rotation_degrees -= DEG_OFFSET
	
