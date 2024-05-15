extends Control

@export var card_scene : PackedScene = null
@export var sprite_frames : SpriteFrames

var unselected_style
var hovered_style
var selected_style
var empty_selected_style
var greyed_out_shader_material

var animated_sprite : AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if sprite_frames:
		animated_sprite = AnimatedSprite2D.new()
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.position += $Panel.size/2
		animated_sprite.z_index = 2
		animated_sprite.play("default")
		animated_sprite.scale = Vector2(3,3)
		$Panel.add_child(animated_sprite)
	unselected_style = StyleBoxFlat.new()
	unselected_style.bg_color = Color(0.6,0.6,0.6,0.5)
	unselected_style.set_corner_radius_all(8)
	hovered_style = unselected_style.duplicate()
	hovered_style.set_border_width_all(2)
	selected_style = hovered_style.duplicate()
	selected_style.border_color = Color(0.0,0.8,0.0,1)
	empty_selected_style = hovered_style.duplicate()
	empty_selected_style.border_color = Color(0.8,0.0,0.0,1)
	greyed_out_shader_material = ShaderMaterial.new()
	greyed_out_shader_material.shader = load("res://views/player_hud/action_button/grey_scale.gdshader")
	$Panel.add_theme_stylebox_override("panel",unselected_style)
	
func set_selected(selected):
	var style;
	if selected:
		if $Panel/Count.text == "0":
			style = empty_selected_style
		else:
			style = selected_style
	else:
		style = unselected_style
	$Panel.add_theme_stylebox_override("panel",style)
	
func set_count(num):
	$Panel/Count.text=str(num);
	if num == 0:
		set_sprite_material(greyed_out_shader_material)
	else:
		set_sprite_material(null)

func set_sprite_material(new_material):
	if animated_sprite != null:
		animated_sprite.material = new_material

