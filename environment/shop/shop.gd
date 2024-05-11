extends StaticBody2D

@export var shop_cost : int = 10

# Import the type of shop you want by supplying the correct interactable
@export var shop_type : PackedScene
@export var shop_sprite_texture : Resource

func _ready():
	$Sprite2D.texture = shop_sprite_texture
	var s = shop_type.instantiate()
	self.add_child(s)
	s.spawn()
