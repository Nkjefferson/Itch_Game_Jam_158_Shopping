extends Node2D

@export var game_over_scene : PackedScene
@export var passive_score_tick : float = 2.5
@export var gold : PackedScene = preload("res://environment/consumables/gold/gold.tscn")
@export var juice : PackedScene = preload("res://environment/consumables/gamer_juice/gamer_juice.tscn")
@export var pack : PackedScene = preload("res://environment/consumables/booster_pack/booster_pack.tscn")

signal score_update

var spawner_list = []
var score = 0
var score_tick_count = 0
var paused = false
var game_over = false

var rng
var coin_percent = 0.82
var juice_percent = 0.11
# This doesnt actually do, anything, its drop rate is calculated by whats leftover
# from the previous 2 things
var pack_percent = 0.07

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.set_chill_state(false)
	MusicManager.play_music("Retailiation")
	$Player.connect("death",_on_game_over)
	self.connect("score_update",$Player.player_hud._update_score)
	var points : Array[Vector2] = [Vector2(-70,279),Vector2(816,-73),Vector2(1386,81),Vector2(304,856)]
	$Spawner.create_spawners(1.0,_on_enemy_death,points)
	rng = RandomNumberGenerator.new()
	self.z_index = 0
	start_level()

func _process(_delta):
	if Input.is_action_just_pressed("escape") and not game_over:
			pause_level()

func start_level():
	$Spawner.start_spawner()

func pause_level():
	var pause_screen = load("res://views/pause_menu/pause_menu.tscn").instantiate()
	self.add_child(pause_screen)
	pause_screen.connect("resume",resume_level)
	get_tree().paused = true

func stop_level():
	$Spawner.stop_spawner()

func resume_level():
	MusicManager.set_chill_state(false)
	get_tree().paused = false

func update_score(value):
	score += value
	score_update.emit(score)

func _on_enemy_death(enemy):
	update_score(enemy.score_value)
	
	var drop_chance = rng.randf()
	print(drop_chance)
	if drop_chance < coin_percent:
		var coin = gold.instantiate()
		self.call_deferred("add_child",coin)
		coin.spawn(enemy.global_position, enemy.gold_reward)
	elif drop_chance >= coin_percent and drop_chance < coin_percent+juice_percent:
		var j = juice.instantiate()
		self.call_deferred("add_child", j)
		j.spawn(enemy.global_position, 10)
	elif drop_chance >= coin_percent+juice_percent:
		var bp = pack.instantiate()
		self.call_deferred("add_child", bp)
		bp.spawn(enemy.global_position, 0)
		
	

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

