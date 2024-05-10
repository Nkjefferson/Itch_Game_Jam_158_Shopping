extends CanvasLayer


func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://levels/first_level/first_level.tscn")

# Called when the settings button is pressed.
func _on_settings_btn_pressed():
	get_tree().change_scene_to_file("res://views/settings_menu/settings_menu.tscn")

# Called when the quit button is pressed
func _on_quit_btn_pressed():
	get_tree().quit()


