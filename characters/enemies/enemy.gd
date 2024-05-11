class_name Enemy
extends CharacterBody2D

signal death

@export var move_speed : int = 100
@export var acceleration : int = 50
@export var health : int = 100
@export var damage : int = 10
@export var score_value : int = 100
@export var damage_tick_rate : float = 0.5
@export var gold_reward : int = 5
@export var sprite : AnimatedSprite2D = null



var destination : Vector2 = Vector2.ZERO
var moving : bool = true
var speed : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if(sprite != null):
		$AnimatedSprite2D.play()
	self.add_to_group("enemies")
	$DamageTickTimer.set_one_shot(true)
	set_motion_mode(MOTION_MODE_FLOATING)
	self.z_index = 2


func take_damage(damage_taken):
	health -= damage_taken
	if health <= 0:
		death.emit(self)
		die()

func move_to_player(delta):
	var parent = get_parent()
	destination = parent.get_node("Player").position
	speed += acceleration * delta
	if speed > move_speed:
		speed = move_speed
	velocity = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5 and moving:
		move_and_slide()

func check_collision():
	if $DamageTickTimer.is_stopped():
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			if collision.get_collider().is_in_group("player"):
				collision.get_collider().take_damage(damage)
				$DamageTickTimer.set_wait_time(damage_tick_rate)
				$DamageTickTimer.start()
				# Drop speed to 0 to allow player to recover, remove when real hur mechanic is created
				speed = 0
				return

func die():
	queue_free()
