extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health = 0 : set = _update_health
var health_tween

func init_health(entity_health):
	health = entity_health
	max_value = health
	value = health
	damage_bar.value = health
	damage_bar.max_value = health

func _update_health(new_health):
	var previous_health = health
	if health_tween and health_tween.is_valid():
		health_tween.kill()
	health_tween = create_tween()
	health = min(max_value, new_health)
	health_tween.tween_property(self,"value",health,0.2)

	if health < previous_health:
		timer.start()
	else:
		damage_bar.value = health

func _on_timer_timeout():
	damage_bar.value = health

func _on_tree_exiting():
	if health_tween:
		health_tween.kill()
