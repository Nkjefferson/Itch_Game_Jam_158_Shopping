extends CanvasLayer

const AudioSettingsMenu = preload("res://views/settings_menu/audio_settings.gd")

var audio_settings = AudioSettingsMenu.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	audio_settings = GameState.load_game_state(audio_settings)
	$VBoxContainer/HBoxMaster/Master_Volume_Slider.value = audio_settings.master_volume_slider_value
	$VBoxContainer/HBoxMusic/Music_Volume_Slider.value = audio_settings.music_volume_slider_value
	$VBoxContainer/HBoxGame/Game_Volume_Slider.value = audio_settings.sound_effects_volume_slider_value
	$VBoxContainer/HBoxMaster/Master_Volume_Mute_Toggle.button_pressed = audio_settings.master_volume_mute_toggle
	$VBoxContainer/HBoxMusic/Music_Volume_Mute_Toggle.button_pressed = audio_settings.music_volume_mute_toggle
	$VBoxContainer/HBoxGame/Game_Volume_Mute_Toggle.button_pressed = audio_settings.sound_effects_volume_mute_toggle
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80 + audio_settings.master_volume_slider_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80 + audio_settings.music_volume_slider_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), -80 + audio_settings.sound_effects_volume_slider_value)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),audio_settings.master_volume_mute_toggle)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),audio_settings.music_volume_mute_toggle)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound Effects"),audio_settings.sound_effects_volume_mute_toggle)

# Called when the exit settings button is pressed.
func _on_exit_btn_pressed():
	GameState.save_game_state(audio_settings)
	get_tree().change_scene_to_file("res://views/main_menu/main_menu.tscn")

func _on_master_volume_slider_value_changed(value):
	audio_settings.master_volume_slider_value = $VBoxContainer/HBoxMaster/Master_Volume_Slider.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80 + audio_settings.master_volume_slider_value)
	
func _on_music_volume_slider_value_changed(value):
	audio_settings.music_volume_slider_value = $VBoxContainer/HBoxMusic/Music_Volume_Slider.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80 + audio_settings.music_volume_slider_value)

func _on_game_volume_slider_value_changed(value):
	audio_settings.sound_effects_volume_slider_value = $VBoxContainer/HBoxGame/Game_Volume_Slider.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), -80 + audio_settings.sound_effects_volume_slider_value)

func _on_master_volume_mute_toggle_toggled(button_pressed):
	audio_settings.master_volume_mute_toggle = button_pressed
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),button_pressed)

func _on_music_volume_mute_toggle_toggled(button_pressed):
	audio_settings.music_volume_mute_toggle = button_pressed
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),button_pressed)

func _on_game_volume_mute_toggle_toggled(button_pressed):
	audio_settings.sound_effects_volume_mute_toggle = button_pressed
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound Effects"),button_pressed)

