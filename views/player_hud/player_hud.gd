extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_hotkey_labels()

func set_hotkey_labels():
	for ability_card in $HUD/Actionbar.get_children():
		ability_card.get_node("Panel/HotkeyLabel").text = InputMap.action_get_events(ability_card.name)[0].as_text().get_slice(" ",0)

func _unhandled_key_input(event):
	if event.is_action_pressed("ActionButton1"):
			$"HUD/Actionbar/ActionButton1".set_selected(true)
	if event.is_action_released("ActionButton1"):
			$"HUD/Actionbar/ActionButton1".set_selected(false)
