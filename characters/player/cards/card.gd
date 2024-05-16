class_name Card
extends Area2D

@export var speed: int = 250
@export var damage: int = 1
@export var throw_sound: Resource
@export var wall_hit_sound: Resource
@export var enemy_hit_sound: Resource

var initial_position
var velocity = 0
var parent_object


func spawn(parent, initial_velocity, target):
	parent_object = parent
	initial_position = parent_object.global_position
	position = initial_position
	# Add some of the players initial velocity to the cards velocity so the card isn't slower than the player
	velocity = initial_velocity / 4
	velocity += (target-initial_position).normalized() * speed
	rotation_degrees = rad_to_deg((target - initial_position).angle())
	
	if $Sprite2D.hframes > 1:
		$Sprite2D.frame = randi_range(0,3)
	
func _physics_process(delta):
	if velocity:
		position += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(self)
		# Level the audio based on distance from player on impact
		MusicManager.play_sound_effect(enemy_hit_sound,-abs((global_position-parent_object.global_position).length())/25)
	else:
		MusicManager.play_sound_effect(wall_hit_sound,-abs((global_position-parent_object.global_position).length())/25)
	queue_free()
