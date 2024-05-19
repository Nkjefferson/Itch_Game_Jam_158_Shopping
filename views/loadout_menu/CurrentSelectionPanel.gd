extends Panel

var card_scene : PackedScene = null
var sprite : Sprite2D
var sprite_frame_count : int = 1
var offset = 5

var length = 40
var last_selected_tile

func _ready():
	size = Vector2.ZERO

func _process(_delta):
	position = get_global_mouse_position() - Vector2(-offset, size.y)
	if Input.is_action_just_released("lclick"):
		clear_card()

func clear_card():
	card_scene = null
	size = Vector2.ZERO
	update_sprite()
	
func update_sprite():
	if card_scene != null:
		var scene = card_scene.instantiate()
		var sprite_frames = scene.get_node("Sprite2D").texture
		$AnimationTimer.stop()
		if sprite_frames:
			size = Vector2(length,length)
			sprite = Sprite2D.new()
			sprite.texture = sprite_frames
			if sprite.texture.get_width() > 16:
				sprite_frame_count = int(float(sprite.texture.get_width())/16)
				sprite.set_hframes(sprite_frame_count)
				$AnimationTimer.start()
			sprite.position += self.size/2
			sprite.z_index = 2
			sprite.scale = Vector2(2,2)
			self.add_child(sprite)
		scene.queue_free()
	else:
		$AnimationTimer.stop()
		if sprite != null:
			sprite.queue_free()

func _on_animation_timer_timeout():
	sprite.frame = (sprite.frame + 1) % sprite_frame_count
