class_name DisplayTile
extends Control

# Variables for sprite setup and control
@export var sprite_scale : int = 3
@export var z_idx : int = 2
var sprite : Sprite2D
var sprite_frame_count : int = 1

# Style variables
var unselected_style
var hovered_style
var selected_style
var empty_selected_style

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

func set_panel_size(sx, sy):
	$Panel.custom_minimum_size = Vector2(sx, sy)
	$Panel.size = Vector2(sx, sy)

func set_sprite_scale(new_scale):
	sprite_scale = new_scale
	if sprite:
		sprite.scale = Vector2(sprite_scale, sprite_scale)

func set_sprite(sprite_frames):
	$AnimationTimer.stop()
	if sprite_frames:
		sprite = Sprite2D.new()
		sprite.texture = sprite_frames
		if sprite.texture.get_width() > 16:
			sprite_frame_count = int(float(sprite.texture.get_width())/16)
			sprite.set_hframes(sprite_frame_count)
			$AnimationTimer.start()
		sprite.position += $Panel.size/2
		sprite.z_index = z_idx
		sprite.scale = Vector2(sprite_scale, sprite_scale)
		$Panel.add_child(sprite)

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

func _on_animation_timer_timeout():
	sprite.frame = (sprite.frame + 1) % sprite_frame_count
