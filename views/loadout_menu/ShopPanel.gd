extends Panel

signal sig_sell
var in_focus : bool = false

# Current contents of the shop inventory
var current_inventory : Array[PackedScene]
@onready var inventory_grid = $Panel/ScrollContainer/GridContainer
# holds the current value of the store that gets applied to the player
# when the accept button is clicked
var current_shop_value : int = 0
var toggle_shop : bool = false

var popup_size = 200

func _ready():
	$Panel.hide()
	#$Panel.size = Vector2(popup_size, popup_size)
	#$Panel.position = self.position #- Vector2(0, popup_size)
	calculate_store_value()
	# Temp, delete later.
	#open_shop()

func _process(_delta):
	if Input.is_action_just_pressed("lclick") and in_focus:
		# Open up the store to view items inside
		if !toggle_shop:
			open_shop()
		else:
			$Panel.hide()
			toggle_shop = false
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

func open_shop():
	set_grid_from_inventory(current_inventory)
	$Panel.show()
	toggle_shop = false
	
func set_grid_from_inventory(inv:Array[PackedScene]):
	clear_inventory_grid()
	for i in range(0, inv.size()):
		var tile = load("res://views/loadout_menu/inventory_tile/inventory_tile.tscn").instantiate()

		tile.get_node("SelectableTile").set_panel_size(40,40)
		tile.get_node("SelectableTile").set_sprite_scale(2)
		tile.get_node("SelectableTile").set_card(inv[i])
		inventory_grid.add_child(tile)
		#tile.queue_free()

func clear_inventory_grid():
	for grid_element in inventory_grid.get_children():
		grid_element.queue_free()

func _on_mouse_entered():
	in_focus = true;

func _on_mouse_exited():
	in_focus = false;
