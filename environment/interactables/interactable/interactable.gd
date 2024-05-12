class_name Interactable
extends Node2D

@export var interact_sound : Resource
@export var sprite_frames : SpriteFrames
@export var cooldown : float = 5.0

var enable_input_monitoring : bool = false
var hitbox_scl : int  = 1
var player_body
var animated_sprite : AnimatedSprite2D
var interaction_timer : Timer
var available : bool = true

# Used if the interactable is owned by another object.
func spawn():
	if sprite_frames:
		animated_sprite = AnimatedSprite2D.new()
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.position -= Vector2(0,16)
		animated_sprite.z_index = 2
		animated_sprite.play("default")
		self.add_child(animated_sprite)
	else:
		printerr("Unable to load sprite sheet in ",self.name)
	interaction_timer = Timer.new()
	interaction_timer.one_shot = true
	interaction_timer.wait_time = cooldown
	self.add_child(interaction_timer)
	interaction_timer.connect("timeout",refresh)
	$CollisionShape2D.shape = get_parent().get_node("CollisionShape2D").shape
	$CollisionShape2D.scale = get_parent().get_node("CollisionShape2D").scale + Vector2(hitbox_scl, hitbox_scl)
	enable_input_monitoring = false

func _process(_delta):
	if enable_input_monitoring:
		if Input.is_action_just_pressed("InteractButton1"):
			if available:
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
	available = false
	interaction_timer.start()
	if animated_sprite:
		animated_sprite.visible = false

func refresh():
	available = true
	if animated_sprite:
		animated_sprite.visible = true
