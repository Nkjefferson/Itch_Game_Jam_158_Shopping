extends Node

const AudioSettingsMenu = preload("res://views/settings_menu/audio_settings.gd")
const SoundEffect = preload("res://resources/music_manager/sound_effect.tscn")

var audio_settings = AudioSettingsMenu.new()

func _ready():
	audio_settings = GameState.load_game_state(audio_settings)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80 + audio_settings.master_volume_slider_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80 + audio_settings.music_volume_slider_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), -80 + audio_settings.sound_effects_volume_slider_value)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),audio_settings.master_volume_mute_toggle)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),audio_settings.music_volume_mute_toggle)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound Effects"),audio_settings.sound_effects_volume_mute_toggle)

func play_music(music_path):
	if $Music.stream == null or $Music.stream.resource_path != music_path:
		$Music.stream = load(music_path)
		$Music.play()

func play_sound_effect(sound_effect_path,volume=0.0):
	var effect = SoundEffect.instantiate()
	add_child(effect)
	effect.connect("effect_ended",_on_sound_effect_finished)
	effect.play_effect(sound_effect_path,volume)

func _on_sound_effect_finished(effect):
	effect.queue_free()

func _on_music_finished():
	$Music.play()
