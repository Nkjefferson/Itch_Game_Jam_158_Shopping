extends Control

var unselected_style
var hovered_style
var selected_style
var empty_selected_style
var greyed_out_shader_material

var sprite : Sprite2D
var sprite_frame_count : int = 1


# Called when the node enters the scene tree for the first time.
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
	greyed_out_shader_material = ShaderMaterial.new()
	greyed_out_shader_material.shader = load("res://views/player_hud/action_button/grey_scale.gdshader")
	$Panel.add_theme_stylebox_override("panel",unselected_style)

func set_card(card_scene):
	var scene : Card = card_scene.card.instantiate()
	self.get_node("Panel").add_child(scene)
	scene.set_physics_process(false)
	scene.get_node("CollisionShape2D").disabled = true
	sprite = scene.get_node("Sprite2D")
	$AnimationTimer.stop()
	if sprite and sprite.texture:
		if sprite.texture.get_width() > 16:
			sprite_frame_count = int(float(sprite.texture.get_width())/16)
			sprite.set_hframes(sprite_frame_count)
			$AnimationTimer.start()
		sprite.position += $Panel.size/2
		sprite.rotation_degrees = 0
		sprite.z_index = 2
		sprite.scale = Vector2(3,3)
	else:
		printerr("Failed to load sprite for action button: " + self.name)

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
	if sprite != null:
		sprite.material = new_material

func _on_animation_timer_timeout():
	sprite.frame = (sprite.frame + 1) % sprite_frame_count
