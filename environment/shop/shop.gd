extends StaticBody2D

@export var shop_cost : int = 10

# Import the type of shop you want by supplying the correct interactable
@export var shop_interactable : PackedScene
@export var shop_type : int = 0

func _ready():
	var s = shop_interactable.instantiate()
	self.add_child(s)
	s.spawn()
	
	match shop_type:
		0:
			$AnimatedSprite2D.play("booster_pack")
		1:
			$AnimatedSprite2D.play("gamer_supp")
		2:
			$AnimatedSprite2D.play("display_case")
