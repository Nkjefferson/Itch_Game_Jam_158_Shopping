extends DisplayTile

var card_scene : PackedScene = null

var offset = 5

var length = 40
var last_selected_tile

func _ready():
	sprite_scale = 2
	$Panel.size = Vector2.ZERO
	$Panel.z_index = z_idx
	super()

func _process(_delta):
	$Panel.position = get_global_mouse_position() - Vector2(-offset, size.y)
	if Input.is_action_just_released("lclick"):
		clear_card()

func clear_card():
	card_scene = null
	$Panel.size = Vector2.ZERO
	update_card()

func set_card(card):
	if card:
		$Panel.size = Vector2(length,length)
	super(card)

func update_card():
	if card_scene != null:
		set_card(card_scene)
	else:
		$AnimationTimer.stop()
		if sprite != null:
			sprite.queue_free()
