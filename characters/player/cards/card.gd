class_name Card
extends Area2D

@export var speed: int = 250
@export var damage: int = 1
@export var rarity: Rarity.CardRarity
@export var refresh_count_override: int = -1
@export var max_count_override: int = -1
@export var throw_sound: Resource
@export var wall_hit_sound: Resource
@export var enemy_hit_sound: Resource

const OFFSET_FROM_PLAYER : int = 5

var initial_position
var velocity = 0
var parent_object
var refresh_count: int = 0
var max_count: int = 0
var card_info : CardInfo

func _ready():
	if !card_info:
		card_info = CardDatabase.get_card_by_name(self.name)
	self.set_name(self.name + "Instance")
	if card_info:
		speed = card_info.speed
		damage = card_info.damage
		refresh_count_override = card_info.refresh_count_override
		max_count_override = card_info.max_count_override
		throw_sound = card_info.throw_sound
		wall_hit_sound = card_info.wall_hit_sound
		enemy_hit_sound = card_info.enemy_hit_sound
	refresh_count = get_refresh_count()
	max_count = get_max_count()


func spawn(parent, target):
	parent_object = parent
	initial_position = parent_object.global_position
	var target_vector : Vector2 = (target - initial_position)
	position = initial_position + (target_vector.normalized() * OFFSET_FROM_PLAYER)
	# Add some of the players initial velocity to the cards velocity so the card isn't slower than the player
	velocity = parent_object.velocity / 4
	velocity += (target_vector).normalized() * speed
	rotation_degrees = rad_to_deg((target - initial_position).angle())
	
	if $Sprite2D.hframes > 1:
		$Sprite2D.frame = randi_range(0,3)

func get_refresh_count():
	if refresh_count_override != -1:
		return refresh_count_override
	return Rarity.get_refresh_count(self.rarity)

func get_max_count():
	if max_count_override != -1:
		return max_count_override
	return Rarity.get_max_count(self.rarity)

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
