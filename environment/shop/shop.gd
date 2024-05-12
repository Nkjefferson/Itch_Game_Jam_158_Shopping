extends StaticBody2D

@export var shop_cost : int = 10

# Import the type of shop you want by supplying the correct interactable
@export var shop_interactable : PackedScene
@export var shop_type : int = 0

var price_label : Label

func _ready():
	var s = shop_interactable.instantiate()
	self.add_child(s)
	if s.name != "Restocker":
		set_price_label()
	s.spawn()
	
	match shop_type:
		0:
			$AnimatedSprite2D.play("booster_pack")
		1:
			$AnimatedSprite2D.play("gamer_supp")
		2:
			$AnimatedSprite2D.play("display_case")

func set_price_label():
	$ShopCostLabel.text = "$" + str(shop_cost)
