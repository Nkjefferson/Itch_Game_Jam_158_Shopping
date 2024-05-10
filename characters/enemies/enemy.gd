extends CharacterBody2D

signal died

@export var move_speed : int = 100
@export var acceleration : int = 50
@export var health : int = 100
@export var damage : int = 10
@export var score_value : int = 100
@export var damage_tick_rate : float = 0.5
@export var sprite : AnimatedSprite2D = null



var destination : Vector2 = Vector2.ZERO
var moving : bool = false
var speed : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if(sprite != null):
		$AnimatedSprite2D.play()
	self.add_to_group("Enemy")
	$DamageTickTimer.set_one_shot(true)
	$DamageTickTimer.stop()
	set_motion_mode(MOTION_MODE_FLOATING)


func take_damage(damage_taken):
	health -= damage_taken
	if health < 0:
		died.emit()
		die()

func move_to_player(delta):
	var parent = get_parent()
	var destination = parent.get_node("Player").position
	speed += acceleration * delta
	if speed > move_speed:
		speed = move_speed
	velocity = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5:
		print(velocity)
		move_and_slide()

func check_collision():
	if $DamageTickTimer.is_stopped():
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			if collision.get_collider().is_in_group("Player"):
				collision.get_collider().take_damage(damage)
				$DamageTickTimer.set_wait_time(damage_tick_rate)
				$DamageTickTimer.start()
				# Drop speed to 0 to allow player to recover, remove when real hur mechanic is created
				speed = 0
				return

func die():
	queue_free()
