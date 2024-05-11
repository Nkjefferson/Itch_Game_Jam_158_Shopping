class_name Basic_Card
extends Area2D

@export var speed: int = 250
@export var dmg: int = 1


func spawn(pos, deg):
	position = pos
	rotation_degrees = deg
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(self.dmg)
	queue_free()
