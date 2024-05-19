extends Control

@export var card_scene : PackedScene = null
signal sig_take
signal sig_give

var unselected_style
var hovered_style
var selected_style
var empty_selected_style

var sprite : Sprite2D
var sprite_frame_count : int = 1

var changing_card : bool = false

var in_focus : bool = false

func _process(_delta):
	if in_focus:
		if Input.is_action_just_pressed("lclick") and card_scene != null:
			set_selected(true)
			sig_take.emit(self)
		if Input.is_action_just_released("lclick"):
			sig_give.emit(self)

func _ready():
	unselected_style = StyleBoxFlat.new()
	unselected_style.bg_color = Color(0.6,0.6,0.6,0.5)
	unselected_style.set_corner_radius_all(8)
	hovered_style = unselected_style.duplicate()
	hovered_style.set_border_width_all(2)
	selected_style = hovered_style.duplicate()
	selected_style.border_color = Color(0.0,0.8,0.0,1)
	empty_selected_style = hovered_style.duplicate()
	empty_selected_style.border_color = Color(0.8,0.0,0.0,1)
	$Panel.add_theme_stylebox_override("panel",unselected_style)

func set_card(card):
	card_scene = card
	update_sprite()
	
func update_sprite():
	if card_scene != null:
		var scene = card_scene.instantiate()
		var sprite_frames = scene.get_node("Sprite2D").texture
		$AnimationTimer.stop()
		if sprite_frames:
			sprite = Sprite2D.new()
			sprite.texture = sprite_frames
			if sprite.texture.get_width() > 16:
				sprite_frame_count = int(float(sprite.texture.get_width())/16)
				sprite.set_hframes(sprite_frame_count)
				$AnimationTimer.start()
			sprite.position += $Panel.size/2
			sprite.scale = Vector2(4,4)
			$Panel.add_child(sprite)
		scene.queue_free()
	else:
		$AnimationTimer.stop()
		if sprite != null:
			sprite.queue_free()

func set_selected(selected):
	var style;
	if selected:
		style = selected_style
	else:
		style = unselected_style
	$Panel.add_theme_stylebox_override("panel",style)
	
func set_sprite_material(new_material):
	if sprite != null:
		sprite.material = new_material

func _on_panel_mouse_entered():
	in_focus = true

func _on_panel_mouse_exited():
	in_focus = false
	set_selected(false)


func _on_animation_timer_timeout():
	sprite.frame = (sprite.frame + 1) % sprite_frame_count
