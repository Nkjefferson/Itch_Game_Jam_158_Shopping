extends Panel

var card_scene : PackedScene = null

var sprite : Sprite2D
var sprite_frame_count : int = 1

@onready var sprite_panel = $Layout/Header_Container/SpritePanel
@onready var sprite_timer = $Layout/Header_Container/SpritePanel/AnimationTimer
@onready var card_info_box = $Layout/Header_Container/Card_Info_Container
@onready var card_desc_label = $Layout/Card_Description

func update_fields():
	update_sprite()
	update_texts()
	
func update_texts():
	if card_scene:
		var card = card_scene.instantiate()
		self.get_node("Layout").get_node("Header_Container").get_node("SpritePanel").add_child(card)
		# Update label text
		card_info_box.get_node("Name_HBox").get_node("NameLabel").text = "Name: "
		card_info_box.get_node("Pack_HBox").get_node("PackLabel").text = "Pack: "
		card_info_box.get_node("Rarity_HBox").get_node("RarityLabel").text = "Rarity: "
		card_info_box.get_node("Value_HBox").get_node("ValueLabel").text = "Value: "
		# Update field text
		card_info_box.get_node("Name_HBox").get_node("NameText").text = card.card_info.card_name
		card_info_box.get_node("Pack_HBox").get_node("PackText").text = ExpansionSet.display_string(card.card_info.pack)
		card_info_box.get_node("Rarity_HBox").get_node("RarityText").text = Rarity.display_string(card.rarity)
		card_info_box.get_node("Value_HBox").get_node("ValueText").text = str(card.value)
		card_desc_label.text = card.card_info.description
		card.queue_free()

func update_sprite():
	if card_scene:
		var scene = card_scene.instantiate()
		self.get_node("Layout").get_node("Header_Container").get_node("SpritePanel").add_child(scene)
		var sprite_frames = scene.get_node("Sprite2D").texture
		sprite_timer.stop()
		if sprite_frames:
			sprite = Sprite2D.new()
			sprite.texture = sprite_frames
			if sprite.texture.get_width() > 16:
				sprite_frame_count = int(float(sprite.texture.get_width())/16)
				sprite.set_hframes(sprite_frame_count)
				sprite_timer.start()
			sprite.position += sprite_panel.size/2
			sprite.scale = Vector2(10,10)
			sprite_panel.add_child(sprite)
		scene.queue_free()
	else:
		sprite_timer.stop()
		if sprite != null:
			sprite.queue_free()

func _set_card(source):
	if card_scene != source.card_scene:
		card_scene = source.card_scene
		update_fields()

func _on_animation_timer_timeout():
	pass # Replace with function body.
