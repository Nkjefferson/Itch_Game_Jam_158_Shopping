class_name Consumable
extends Area2D

@export var interact_sound : Resource
@export var consumable_z_index : int = 1

var stuck_in_wall : bool = false
var speed = 50

func _ready():
	add_to_group("consumable")

func spawn(pos, _val):
	position = pos
	self.z_index = consumable_z_index

func _process(delta):
	if stuck_in_wall:
		var target = get_parent().get_node("Player").position
		var direction = position.direction_to(target).normalized()
		var velocity = direction * speed * delta
		position += velocity
	else:
		pass

	
func _on_body_entered(body):
	if body.is_in_group("player"):
		self.apply_effect(body)
		if interact_sound:
			MusicManager.play_sound_effect(interact_sound)
		else:
			printerr("No interactive SFX found in: ",self.name)
		self.queue_free()
	elif body is TileMap:
		stuck_in_wall = true
		
func apply_effect(_body):
	pass

func _on_body_exited(body):
	if body is TileMap:
		stuck_in_wall = false
