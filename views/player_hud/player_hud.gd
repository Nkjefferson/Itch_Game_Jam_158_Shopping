extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = self.get_parent().get_parent()
	player.connect("player_health_updated",_update_health_value)
	var inventory = player.get_node("Inventory")
	inventory.connect("update_card_count", _update_card_hotbar)
	inventory.connect("update_gold_amount", _update_gold)
	set_hotkey_labels()

func set_hotkey_labels():
	for ability_card in $HUD/Actionbar.get_children():
		ability_card.get_node("Panel/HotkeyLabel").text = InputMap.action_get_events(ability_card.name)[0].as_text().get_slice(" ",0)

func _update_card_hotbar(index, count):
	var hotkey_labels = $HUD/Actionbar.get_children()
	hotkey_labels[index].set_count(count)

func _update_health_value(health):
	$HUD/HealthBar/Value.text = str(health)
	
func _update_score(score):
	$HUD/ScoreTicker/Value.text = str(score)
	
func _update_gold(gold):
	$HUD/CurrencyTicker/Value.text = str(gold)

func _unhandled_key_input(event):
	if event.is_action_pressed("ActionButton1"):
			$"HUD/Actionbar/ActionButton1".set_selected(true)
	if event.is_action_released("ActionButton1"):
			$"HUD/Actionbar/ActionButton1".set_selected(false)
	if event.is_action_pressed("ActionButton2"):
			$"HUD/Actionbar/ActionButton2".set_selected(true)
	if event.is_action_released("ActionButton2"):
			$"HUD/Actionbar/ActionButton2".set_selected(false)
	if event.is_action_pressed("ActionButton3"):
			$"HUD/Actionbar/ActionButton3".set_selected(true)
	if event.is_action_released("ActionButton3"):
			$"HUD/Actionbar/ActionButton3".set_selected(false)
