extends Enemy

func _ready():
	super._ready()
	
func _process(_delta):
	pass
	
func move_to_player(delta):
	destination = parent.get_node("Player").position
	speed += acceleration * delta
	if abs(speed) > move_speed:
		var modifier = 1
		if speed < 0:
			modifier = -1
		speed = move_speed * modifier
	velocity = position.direction_to(destination) * speed
	$AnimatedSprite2D.flip_h = position.direction_to(destination).x < 0
	if position.distance_to(destination) > 5 and moving:
		move_and_slide()

func _physics_process(delta):
	move_to_player(delta)
	check_collision()

