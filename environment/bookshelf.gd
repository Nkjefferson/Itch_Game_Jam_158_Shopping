extends Node2D

@export var BASE_PIXEL_SIZE : int = 16
@export var width : int = 1
@export var length : int = 1

func _ready():
# Modify the length of the collision box based on how many shelves are part of it.
	$StaticBody2D/CollisionShape2D.scale = Vector2(width, length)
	#$StaticBody2D/CollisionShape2D.shape.extents = Vector2(width * BASE_PIXEL_SIZE, length * BASE_PIXEL_SIZE)
	$Sprite2D.hide()
	$TileMap.add_layer(0)
	$TileMap.set_cell(0,Vector2(0,0),0,Vector2i(0,0),0)
	$TileMap.set_layer_enabled(0, true)
	$StaticBody2D/Restocker.spawn()

func _process(_delta):
	pass
