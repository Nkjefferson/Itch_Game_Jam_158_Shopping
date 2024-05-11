class_name Interactable
extends Node2D

var enable_input_monitoring : bool = false
var hitbox_scl : int  = 1
var player_body

# Used if the interactable is owned by another object.
func spawn():
	$CollisionShape2D.shape = get_parent().get_node("CollisionShape2D").shape
	$CollisionShape2D.scale = get_parent().get_node("CollisionShape2D").scale + Vector2(hitbox_scl, hitbox_scl)
	enable_input_monitoring = false

func _process(_delta):
	if enable_input_monitoring:
		if Input.is_action_just_pressed("InteractButton1"):
			interact()

func _on_body_entered(body):
	if(body.is_in_group("player")):
		player_body = body
		enable_input_monitoring = true

func _on_body_exited(body):
	if(body.is_in_group("player")):
		player_body = null
		enable_input_monitoring = false
	
func interact():
	pass
