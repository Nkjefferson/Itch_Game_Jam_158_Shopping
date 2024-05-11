extends Node2D

@export var game_over_scene : PackedScene
@export var passive_score_tick : float = 2.5

signal score_update

var spawner_list = []
var score = 0
var score_tick_count = 0
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_music("res://assets/audio/House In a Forest Loop Reversed.ogg")
	$Player.connect("player_death",_on_game_over)
	self.connect("score_update",$Player/Camera2D/PlayerHud._update_score)
	var points : Array[Vector2] = [Vector2(10,411),Vector2(678,11),Vector2(1444,393),Vector2(729,869)]
	$Spawner.create_spawners(1.0,_on_enemy_death_score,points)
	$Spawner.start_spawner()
	self.z_index = 0

func update_score(value):
	score += value
	score_update.emit(score)

func _on_enemy_death_score(value):
	update_score(value)

func _on_pack_collected_score(value):
	update_score(value);

func _on_score_timer_timeout():
	score_tick_count += 1
	update_score(int(passive_score_tick * score_tick_count))

func _on_game_over():
	if !game_over:
		game_over = true
		$Spawner.stop_spawner()
		var game_over_menu = game_over_scene.instantiate()
		self.add_child(game_over_menu)
		game_over_menu.update_metrics(score)
	

