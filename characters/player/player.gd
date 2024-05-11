extends CharacterBody2D


const MAX_SPEED = 200.0
const ACCELERATION : float = 700

var destination : Vector2 = Vector2.ZERO
var moving : bool = false
var speed : float = 0.0

@export var Basic_Card : PackedScene

func _ready():
	player_health_updated.emit(health)
	set_motion_mode(MOTION_MODE_FLOATING)

func _process(_delta):
	if Input.is_action_just_pressed("ActionButton1"):
		shoot(Basic_Card)
	if Input.is_action_just_pressed("ActionButton2"):
		shoot(Piercing_Card)
		
func _physics_process(delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		destination = get_global_mouse_position()
		moving = true
	
	movement_loop(delta)
	
func movement_loop(delta):
	if moving ==false:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	velocity = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5:
		move_and_slide()
	else:
		moving = false

func shoot(card_scene):
	var target = get_global_mouse_position()
	var target_degrees = rad_to_deg((target - $Marker2D.global_position).angle())
	var c = card_scene.instantiate()
	add_child(c)
	c.spawn($Marker2D.position, target_degrees)
