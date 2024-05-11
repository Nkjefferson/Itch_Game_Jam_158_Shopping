extends Node

signal effect_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.autoplay = true


func play_effect(path,volume):
	$AudioStreamPlayer.stream = path
	$AudioStreamPlayer.set_volume_db(volume)
	$AudioStreamPlayer.play()

func _on_sound_effect_finished():
	self.queue_free()
