extends Node

const AudioSettingsMenu = preload("res://views/settings_menu/audio_settings.gd")
const SoundEffect = preload("res://resources/music_manager/sound_effect.tscn")

var audio_settings = AudioSettingsMenu.new()
var music_path = ""
var music_path_chill = ""
var song_name = ""
var chill_state = false

var audio_fade

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	audio_fade = get_tree().create_tween()
	audio_settings = GameState.load_game_state(audio_settings)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80 + audio_settings.master_volume_slider_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80 + audio_settings.music_volume_slider_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), -80 + audio_settings.sound_effects_volume_slider_value)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),audio_settings.master_volume_mute_toggle)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),audio_settings.music_volume_mute_toggle)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound Effects"),audio_settings.sound_effects_volume_mute_toggle)

func play_music(music_name):
	song_name = music_name
	music_path = "res://assets/audio/" + music_name + ".ogg"
	music_path_chill = "res://assets/audio/" + music_name + "Chill.ogg"
	if $Music.stream == null or $Music.stream.resource_path != music_path:
		$Music.stream = load(music_path)
		$Music.play()
	if $MusicCalm.stream == null or $MusicCalm.stream.resource_path != music_path_chill:
		$MusicCalm.stream = load(music_path_chill)
		$MusicCalm.play()
	if chill_state:
		audio_fade.tween_property($Music,"volume_db",-70,1.0)
		audio_fade.tween_property($MusicCalm,"volume_db",0,1.0)
		#$Music.volume_db = -70
		#$MusicCalm.volume_db = 0
	else:
		$Music.volume_db = 0
		$MusicCalm.volume_db = -70
		
func set_chill_state(chill):
	chill_state = chill

func play_sound_effect(sound_effect_path,volume=0.0):
	var effect = SoundEffect.instantiate()
	add_child(effect)
	effect.connect("effect_ended",_on_sound_effect_finished)
	effect.play_effect(sound_effect_path,volume)

func _on_sound_effect_finished(effect):
	effect.queue_free()

func _on_music_finished():
	if song_name == "Retailiation":
		$Music.play(4.266)
		$MusicCalm.play(4.266)
	if song_name == "Title":
		$Music.play(4.8)
		$MusicCalm.play(4.8)
