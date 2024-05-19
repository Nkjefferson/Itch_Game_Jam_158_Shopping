extends Panel

signal sig_sell
var in_focus : bool = false

# Current contents of the shop inventory
var current_inventory : Array[PackedScene]
# holds the current value of the store that gets applied to the player
# when the accept button is clicked
var current_shop_value : int = 0

func _ready():
	calculate_store_value()

func _process(_delta):
	if Input.is_action_just_pressed("lclick") and in_focus:
		# Open up the store to view items inside
		pass
	elif Input.is_action_just_released("lclick") and in_focus:
		# "Sell" the item that is passed here
		sig_sell.emit()

func add_card_to_store(card_to_sell : PackedScene):
	if card_to_sell != null:
		current_inventory.append(card_to_sell)
		calculate_store_value()

func remove_card_from_store():
	calculate_store_value()
	pass

func calculate_store_value():
	current_shop_value = 0
	for card in current_inventory:
		# Replace 1 with whatever the cards value is
		current_shop_value += 1
	$ValueLabel.text = str(current_shop_value)
		
func _on_mouse_entered():
	in_focus = true;

func _on_mouse_exited():
	in_focus = false;
