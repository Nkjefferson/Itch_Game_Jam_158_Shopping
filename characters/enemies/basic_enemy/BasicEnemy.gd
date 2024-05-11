extends Enemy

# Exported Variable Values:
# Move Speed: 200
# Health: 100
# Damage: 10
# Score Value: 100

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super.move_to_player(delta)
	check_collision()

