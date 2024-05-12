extends CanvasLayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called when the exit settings button is pressed.
func _on_exit_btn_pressed():
	queue_free()
