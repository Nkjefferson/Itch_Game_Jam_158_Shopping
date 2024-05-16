extends Enemy

# Exported Variable Values:
# Move Speed: 200
# Health: 100
# Damage: 10
# Score Value: 100

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super.move_to_player(delta)
	check_collision()

