class_name Basic_Card
extends Area2D

@export var speed: int = 250
@export var dmg: int = 1
@export var throw_sound: Resource
@export var wall_hit_sound: Resource
@export var enemy_hit_sound: Resource


func spawn(pos, deg):
	position = pos
	rotation_degrees = deg
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(self.dmg)
		#TODO: Play around with distance from sound function
		MusicManager.play_sound_effect(enemy_hit_sound,-position.length()/25)
	else:
		MusicManager.play_sound_effect(wall_hit_sound,-position.length()/25)
	queue_free()
