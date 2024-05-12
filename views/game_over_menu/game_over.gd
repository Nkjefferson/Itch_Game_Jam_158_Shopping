extends CanvasLayer

var score_tween

var Settings = preload("res://views/settings_menu/settings_menu_hud.tscn")
var Card_Collection = preload("res://views/card_binder_menu/card_binder_menu.tscn");

func _ready():
	MusicManager.set_chill_state(true)
	MusicManager.play_music("Retailiation")
	score_tween = get_tree().create_tween()

func update_metrics(score):
	score_tween.tween_method(set_score_text,0,score,2).set_delay(1)

func set_score_text(score):
	$Control/ScoreTicker/Value.text = str(score)

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://environment/level/level.tscn")

# Called when the settings button is pressed.
func _on_settings_btn_pressed():
	var settings_menu = Settings.instantiate()
	get_parent().add_child(settings_menu)

# Called when the quit button is pressed
func _on_quit_btn_pressed():
	get_tree().quit()


func _on_card_collection_btn_pressed():
	var card_menu = Card_Collection.instantiate()
	get_parent().add_child(card_menu)
