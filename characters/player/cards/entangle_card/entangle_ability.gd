extends Area2D

var affected_enemies : Array[CharacterBody2D] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		affected_enemies.append(body)
		body.moving = false


func _on_timer_timeout():
	for enemy in affected_enemies:
		enemy.moving = true
	queue_free()
