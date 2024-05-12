class_name Interactable
extends Node2D

@export var interact_sound : Resource
@export var insufficient_funds_sound : Resource = load("res://assets/audio/sound_effects/Empty.wav")
@export var sprite_frames : SpriteFrames
@export var interact_indicator_sprite_frames : SpriteFrames = load("res://environment/interactables/interactable/interaction_default_spriteframes.tres")
@export var cooldown : float = 5.0

var enable_input_monitoring : bool = false
var hitbox_scl : int  = 1
var player_body
var animated_sprite : AnimatedSprite2D
var indicator_sprite : AnimatedSprite2D
var keybind_text : Label
var interaction_timer : Timer
var available : bool = true

# Used if the interactable is owned by another object.
func spawn():
	if sprite_frames:
		animated_sprite = AnimatedSprite2D.new()
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.position -= Vector2(0,16)
		animated_sprite.z_index = 3
		animated_sprite.play("default")
		self.add_child(animated_sprite)
	else:
		printerr("Unable to load sprite sheet in ",self.name)

	create_indicator()
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
		if available:
			indicator_sprite.visible = true

func _on_body_exited(body):
	if(body.is_in_group("player")):
		player_body = null
		enable_input_monitoring = false
		indicator_sprite.visible = false

func interact():
	available = false
	interaction_timer.start()
	if animated_sprite:
		animated_sprite.visible = false
	indicator_sprite.visible = false

func refresh():
	available = true
	if animated_sprite:
		animated_sprite.visible = true
	if enable_input_monitoring:
		indicator_sprite.visible = true

func create_indicator():
	indicator_sprite = AnimatedSprite2D.new()
	indicator_sprite.sprite_frames = interact_indicator_sprite_frames
	indicator_sprite.position -= Vector2(-16,16)
	indicator_sprite.z_index = 3
	indicator_sprite.play("default")
	indicator_sprite.visible = false
	keybind_text = Label.new()
	keybind_text.scale = Vector2(0.5,0.5)
	keybind_text.position -= Vector2(2,7)
	keybind_text.text = InputMap.action_get_events("InteractButton1")[0].as_text().get_slice(" ",0)
	indicator_sprite.add_child(keybind_text)
	self.add_child(indicator_sprite)
