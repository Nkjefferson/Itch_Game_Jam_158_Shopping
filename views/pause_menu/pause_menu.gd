extends CanvasLayer

signal resume

var Settings = preload("res://views/settings_menu/settings_menu_hud.tscn")
var Card_Collection = preload("res://views/card_binder_menu/card_binder_menu.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		resume.emit()
		queue_free()

func _on_resume_btn_pressed():
	resume.emit()
	queue_free()

# Called when the settings button is pressed.
func _on_settings_btn_pressed():
	var settings_menu = Settings.instantiate()
	get_parent().add_child(settings_menu)

# Called when the quit button is pressed
func _on_quit_btn_pressed():
	get_tree().quit()

func _on_main_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://views/main_menu/main_menu.tscn")

func _on_card_collection_btn_pressed():
	var card_menu = Card_Collection.instantiate()
	get_parent().add_child(card_menu)
