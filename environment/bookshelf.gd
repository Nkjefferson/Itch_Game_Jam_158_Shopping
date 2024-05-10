extends Node2D

@export var BASE_PIXEL_SIZE : int = 16
@export var width : int = 1
@export var length : int = 1

func _ready():
# Modify the length of the collision box based on how many shelves are part of it.
	$StaticBody2D/CollisionShape2D.scale = Vector2(width, length)
	#$StaticBody2D/CollisionShape2D.shape.extents = Vector2(width * BASE_PIXEL_SIZE, length * BASE_PIXEL_SIZE)
	$Sprite2D.scale = Vector2(width, length)

func _process(delta):
	pass
