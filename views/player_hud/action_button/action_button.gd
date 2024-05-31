extends DisplayTile

@export var card_scene : PackedScene = null

var greyed_out_shader_material

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	greyed_out_shader_material = ShaderMaterial.new()
	greyed_out_shader_material.shader = load("res://views/player_hud/action_button/grey_scale.gdshader")

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
