class_name AudioSettings
extends Resource

@export var master_volume_slider_value = 60
@export var music_volume_slider_value = 80
@export var sound_effects_volume_slider_value = 80
@export var master_volume_mute_toggle = false
@export var music_volume_mute_toggle = false
@export var sound_effects_volume_mute_toggle = false

func print_name():
	return "AudioSettings"
