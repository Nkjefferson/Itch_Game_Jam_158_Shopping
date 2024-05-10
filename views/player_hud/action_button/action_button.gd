extends Control

@export var card_scene : PackedScene = null

var unselected_style
var hovered_style
var selected_style
var greyed_out_shader_material

var card

# Called when the node enters the scene tree for the first time.
func _ready():
	unselected_style = StyleBoxFlat.new()
	unselected_style.set_corner_radius_all(8)
	hovered_style = unselected_style.duplicate()
	hovered_style.set_border_width_all(2)
	selected_style = hovered_style.duplicate()
	selected_style.border_color = Color(0.0,0.8,0.0,1)
	greyed_out_shader_material = ShaderMaterial.new()
	greyed_out_shader_material.shader = load("res://views/player_hud/action_button/grey_scale.gdshader")
	$Panel.add_theme_stylebox_override("panel",unselected_style)
	# assert(card != null,"Shop Item has no instantiated tower")
	
func set_selected(selected):
	var style;
	if selected:
		style = selected_style
	else:
		style = unselected_style
	$Panel.add_theme_stylebox_override("panel",style)
