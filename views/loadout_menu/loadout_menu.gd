extends CanvasLayer

# Eventually replace this with importing from a linked inventory
@export var temp_loadout : Array[PackedScene]

@export var temp_inventory : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_hotkey_labels()
	set_action_bar_loadout(temp_loadout)
	update_grid(temp_inventory)
	
	for ability_card in $Layout/Hotbar.get_children():
		ability_card.get_node("SelectableTile").connect("sig_take",$CurrentSelectionPanel._take_card_from_tile)
		ability_card.get_node("SelectableTile").connect("sig_give",$CurrentSelectionPanel._give_card_to_tile)

func set_hotkey_labels():
	var i = 2
	for ability_card in $Layout/Hotbar.get_children():
		ability_card.get_node("HotkeyLabel").text = InputMap.action_get_events("ActionButton" + str(i))[0].as_text().get_slice(" ",0)
		i+=1

func set_action_bar_loadout(loadout:Array[PackedScene]):
	for i in range(0,loadout.size()):
		if loadout[i]:
			$Layout/Hotbar.get_node("Hotbar_Tile" + str(i+2)).get_node("SelectableTile").set_card(loadout[i])

func update_grid(inventory:Array[PackedScene]):
	for i in range(0, inventory.size()):
		var tile = load("res://views/loadout_menu/inventory_tile/inventory_tile.tscn").instantiate()
		tile.get_node("SelectableTile").set_card(inventory[i])
		$Layout/ScrollContainer/GridContainer.add_child(tile)
	
func _on_accept_button_pressed():
	pass # Replace with function body.

func _on_cancel_button_pressed():
	pass # Replace with function body.
