extends Node2D

var Settings = preload("res://views/settings_menu/settings_menu_hud.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_music("res://assets/audio/Shop-Title.ogg")



func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://environment/level/level.tscn")

# Called when the settings button is pressed.
func _on_settings_btn_pressed():
	var settings_menu = Settings.instantiate()
	get_parent().add_child(settings_menu)

# Called when the quit button is pressed
func _on_quit_btn_pressed():
	get_tree().quit()
