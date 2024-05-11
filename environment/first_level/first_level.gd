extends Node2D

@export var mob_scene : PackedScene
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
	generate_spawner_list()
	$EnemySpawners/SpawnTimer.start()
	$Player.connect("player_death",_on_game_over)
	self.connect("score_update",$Player/Camera2D/PlayerHud._update_score)

func update_score(value):
	score += value
	score_update.emit(score)

func generate_spawner_list():
	for spawner in $EnemySpawners.get_children():
		if spawner is Marker2D:
			spawner_list.append(spawner)

func spawn_enemy(enemy):
	var mob = mob_scene.instantiate()
	var spawn_location = spawner_list[randi()%spawner_list.size()].position
	mob.position = spawn_location
	mob.connect("died",_on_enemy_death_score)
	add_child(mob)

func _on_enemy_death_score(value):
	update_score(value)

func _on_pack_collected_score(value):
	update_score(value);

func _on_spawn_timer_timeout():
	spawn_enemy("yo")

func _on_score_timer_timeout():
	score_tick_count += 1
	update_score(int(passive_score_tick * score_tick_count))

func _on_game_over():
	if !game_over:
		game_over = true
		var game_over_menu = game_over_scene.instantiate()
		self.add_child(game_over_menu)
		game_over_menu.update_metrics(score)
	

