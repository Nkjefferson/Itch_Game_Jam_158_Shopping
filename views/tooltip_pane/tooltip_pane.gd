extends Control


@onready var panel_container = $PanelContainer
@onready var top_level_vertical_container= $PanelContainer/VBoxContainer
@onready var texture_rect = $PanelContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var title = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Title
@onready var texture_labels = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer


func set_texture(texture:Texture,frame_count:int=1):
	if texture:
		if texture_rect.texture is AtlasTexture:
			texture_rect.texture.queue_free()
		if frame_count == 1:
			texture_rect.texture = texture
		else:
			texture_rect.texture = AtlasTexture.new()
			texture_rect.texture.set_atlas(texture)
			texture_rect.texture.set_region(Rect2(0,0,texture.get_size().x/frame_count,texture.get_size().y))
			texture_rect.texture.set_filter_clip(true)

func scale_texture(scale_factor:Vector2):
	if texture_rect.texture:
		if !texture_rect.texture is AtlasTexture:
			texture_rect.set_custom_minimum_size(texture_rect.texture.get_size() * scale_factor)
		else:
			texture_rect.set_custom_minimum_size(texture_rect.texture.get_region().size*scale_factor)

func set_title(title_text:String):
	title.text = title_text

func add_subtitle(subtitle_text:String):
	var label = Label.new()
	label.text = subtitle_text
	texture_labels.add_child(label)

func add_paragraph(paragraph_text:String):
	var label = Label.new()
	label.text = paragraph_text
	top_level_vertical_container.add_child(label)

func get_width():
	return panel_container.get_size().x

func get_height():
	return panel_container.get_size().y

func move(move_vector:Vector2):
	panel_container.position += move_vector
