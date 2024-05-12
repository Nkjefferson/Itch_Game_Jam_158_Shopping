extends CharacterBody2D

signal player_health_updated(int)
signal death

@export var max_speed : int  = 200
@export var acceleration : int = 700
@export var max_health : int = 100
@export var player_hud_scene : PackedScene
@export var marker_frames : SpriteFrames
@export var death_sound : Resource


var player_camera : Camera2D
var destination : Vector2 = Vector2.ZERO
var moving : bool = false
var speed : float = 0.0
var health : int
var player_hud
var marker : AnimatedSprite2D


func _ready():
	self.z_index = 2
	health = max_health
	self.add_to_group("player")
	set_motion_mode(MOTION_MODE_FLOATING)
	# Create player sub-elements
	create_player_camera()
	create_player_hud()
	# Inventory and signal management
	$Inventory.update_gold_amount.emit($Inventory.gold)
	$Inventory.connect("update_card_count", player_hud._update_card_hotbar)
	$Inventory.connect("update_gold_amount", player_hud._update_gold)
	self.connect("player_health_updated",player_hud._update_health_value)
	# Push initial player health
	player_health_updated.emit(health)
	$Inventory.refresh_hotbar()
	$AnimatedSprite2D.play("Idle")
	
	marker = AnimatedSprite2D.new()
	marker.sprite_frames = marker_frames
	marker.z_index = 3
	marker.play("default")
	get_parent().add_child.call_deferred(marker)
	marker.visible = false

func create_player_camera():
	player_camera = Camera2D.new()
	player_camera.zoom = (Vector2(2,2))
	self.add_child(player_camera)

func create_player_hud():
	if player_camera:
		if player_hud_scene:
			player_hud = player_hud_scene.instantiate()
			player_camera.add_child(player_hud)
		else:
			printerr("Could not create player HUD: no PackedScene provided")
	else:
		printerr("Could not create player HUD, no camera to attach to")

func _process(_delta):
	var mouse_direction = position.direction_to(get_global_mouse_position()).x
	$AnimatedSprite2D.flip_h = mouse_direction < 0
	for i in range(0,5):
		if Input.is_action_just_pressed(("ActionButton" + str(i+1))):
			shoot(i)
		
func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		destination = get_global_mouse_position()
		print(destination)
		marker.global_position = destination - Vector2(0,8)
		if !marker.visible:
			marker.visible = true
		moving = true
		$AnimatedSprite2D.play("Run")
	
	movement_loop(delta)
	
func movement_loop(delta):
	if moving == false:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	velocity = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5:
		move_and_slide()
	else:
		marker.visible = false
		moving = false
		$AnimatedSprite2D.play("Idle")

func shoot(slot):
	var target = get_global_mouse_position()
	var card_type = $Inventory.shoot(slot)
	if card_type != null:
		var c = card_type.instantiate()
		get_parent().add_child(c)
		c.spawn(self, velocity, target)
		MusicManager.play_sound_effect(c.throw_sound)

func take_damage(damage):
	health -= damage
	if health <= 0:
		health = 0
		$AnimatedSprite2D.play("Die")
		if death_sound:
			MusicManager.play_sound_effect(death_sound)
		else:
			printerr("No death SFX found in: ",self.name)
		self.set_physics_process(false)
		$CollisionShape2D.disabled=true
		await $AnimatedSprite2D.animation_finished
		death.emit()
	player_health_updated.emit(health)

func heal(damage):
	health = clamp(health+damage, health, max_health)
	player_health_updated.emit(health)
