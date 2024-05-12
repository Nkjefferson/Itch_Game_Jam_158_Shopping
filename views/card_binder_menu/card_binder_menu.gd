extends CanvasLayer



func _ready():

	MusicManager.set_chill_state(true)
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called when the exit settings button is pressed.
func _on_exit_btn_pressed():
	MusicManager.set_chill_state(MusicManager.menu_chill_state)
	queue_free()
