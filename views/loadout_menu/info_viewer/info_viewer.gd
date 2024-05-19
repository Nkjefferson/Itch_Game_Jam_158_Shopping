extends Panel

var card_scene : PackedScene = null

var sprite : Sprite2D
var sprite_frame_count : int = 1

@onready var sprite_panel = $Layout/Header_Container/SpritePanel
@onready var sprite_timer = $Layout/Header_Container/SpritePanel/AnimationTimer

func update_fields():
	update_sprite()
	update_texts()
	
func update_texts():
	pass

func update_sprite():
	if card_scene != null:
		var scene = card_scene.instantiate()
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
