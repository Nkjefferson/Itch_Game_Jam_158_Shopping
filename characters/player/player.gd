extends CharacterBody2D


const MAX_SPEED = 200.0
const ACCELERATION : float = 700

var destination : Vector2 = Vector2.ZERO
var moving : bool = false
var speed : float = 0.0



func _physics_process(delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		destination = get_global_mouse_position()
		moving = true
	
	movement_loop(delta)
	
func movement_loop(delta):
	if moving ==false:
		speed = 0
	else:
		speed += ACCELERATION * delta
		if speed > MAX_SPEED:
			speed = MAX_SPEED
	velocity = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5:
		move_and_slide()
	else:
		moving = false
