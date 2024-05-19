extends CanvasLayer

# Inputs: Eventually replace this with importing from a linked inventory
@export var temp_loadout : Array[PackedScene]
@export var temp_inventory : Array[PackedScene]

@onready var shop_panel = $Layout/ShopPanel
@onready var inventory_grid = $Layout/HBoxContainer/InventoryPanel/ScrollContainer/InventoryGrid

# Local up to date versions of the inventory and loadout for the player
var loadout : Array[PackedScene]
var inventory : Array[PackedScene]

# Local variables to track tile selections
var last_selected_tile
# Called when the node enters the scene tree for the first time.
func _ready():
	loadout = temp_loadout
	inventory = temp_inventory
	set_hotkey_labels()
	set_action_bar_loadout(loadout)
	set_grid_from_inventory(inventory)
	
	# Connect Signals
	for ability_card in $Layout/Hotbar.get_children():
		# Connect the selection panel to the hotbar tiles
		ability_card.get_node("SelectableTile").connect("sig_take",_take_card_from_tile)
		ability_card.get_node("SelectableTile").connect("sig_give",_give_card_to_tile)
		# Connect the info viewer to the hotbar tiles
		ability_card.get_node("SelectableTile").connect("sig_take",$Layout/HBoxContainer/InfoViewer._set_card)
		
	# Connect the SelectionPanel to the Shop
	shop_panel.connect("sig_sell",_sell_card)

# Functions to manage the hotbar/action bar
func set_hotkey_labels():
	var i = 2
	for ability_card in $Layout/Hotbar.get_children():
		ability_card.get_node("HotkeyLabel").text = InputMap.action_get_events("ActionButton" + str(i))[0].as_text().get_slice(" ",0)
		i+=1

func set_action_bar_loadout(loadout:Array[PackedScene]):
	for i in range(0,loadout.size()):
		if loadout[i]:
			$Layout/Hotbar.get_node("Hotbar_Tile" + str(i+2)).get_node("SelectableTile").set_card(loadout[i])

# Functions to manage the inventory grid
func set_grid_from_inventory(inv:Array[PackedScene]):
	clear_inventory_grid()
	for i in range(0, inv.size()):
		var tile = load("res://views/loadout_menu/inventory_tile/inventory_tile.tscn").instantiate()
		tile.get_node("SelectableTile").set_card(inv[i])
		inventory_grid.add_child(tile)
		# Connect the selection panel to the Inventory tiles
		tile.get_node("SelectableTile").connect("sig_take",_take_card_from_tile)
		tile.get_node("SelectableTile").connect("sig_give",_give_card_to_tile)
		# Connect the info viewer to the Inventory tiles
		tile.get_node("SelectableTile").connect("sig_take",$Layout/HBoxContainer/InfoViewer._set_card)
	
func clear_inventory_grid():
	for grid_element in inventory_grid.get_children():
		grid_element.queue_free()

func update_inventory_from_grid():
	var new_inventory : Array[PackedScene]
	for grid_element in inventory_grid.get_children():
		new_inventory.append(grid_element.get_node("SelectableTile").card_scene)
	inventory = new_inventory

# Functions to manage shop interactions
func _sell_card():
	var tile = last_selected_tile
	if tile != null:
		if tile.get_parent().get_parent().name == "InventoryGrid":
			last_selected_tile = null
			shop_panel.add_card_to_store(tile.card_scene)
			tile.set_card(null)
			# Update inventory array, and then remove the clean up grid 
			update_inventory_from_grid()
			var new_inventory : Array[PackedScene]
			for card in inventory:
				if card != null:
					new_inventory.append(card)
			inventory = new_inventory
			set_grid_from_inventory(inventory)

# Functions to manage interactions between the CurrentSelectionPanel and the
# other elements on screen
func _take_card_from_tile(source):
	if source.card_scene != null:
		source.changing_card = true
		$CurrentSelectionPanel.card_scene = source.card_scene
		$CurrentSelectionPanel.update_sprite()
		last_selected_tile = source

func _give_card_to_tile(dest):
	if dest != last_selected_tile:
		if $CurrentSelectionPanel.card_scene != null:
			last_selected_tile.set_card(dest.card_scene)
			dest.set_card(null)
			dest.set_card($CurrentSelectionPanel.card_scene)
			update_inventory_from_grid()
	$CurrentSelectionPanel.clear_card()
	last_selected_tile = null


func _on_accept_button_pressed():
	pass # Replace with function body.

func _on_cancel_button_pressed():
	pass # Replace with function body.
