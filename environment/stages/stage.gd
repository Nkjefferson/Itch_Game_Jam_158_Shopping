extends Node2D
class_name Stage

@export var points : Array[Vector2] = [Vector2(-70,279),Vector2(816,-73),Vector2(1386,81),Vector2(304,856)]
@export var spawner_scene : PackedScene = preload("res://environment/spawner/spawner.tscn")
@export var spawned_entities : Array[SpawnedEntity]
@export var boss_scene : PackedScene = preload("res://characters/bosses/boss.tscn")
@export var initial_spawn_interval : float = 3.0
@export var minimum_spawn_rate : float = 0.75
@export var spawn_increase_rate : float = 0.05
@export var total_enemies : int = 30

var spawner
var spawner_list = []
var _level_completion_function

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner = spawner_scene.instantiate()
	self.add_child(spawner)

func load_level(parent):
	var spawn_locations : Array[Vector2] = []
	for node in get_children():
		if node is Marker2D and node.name != "PlayerSpawnMarker":
			spawn_locations.append(node.global_position)
	if spawn_locations.size() > 0:
		points = spawn_locations
	spawner.create_spawners(3.0,0.75,0.05,50,parent._on_enemy_death,points,spawned_entities)
	spawner.connect("finished",_spawn_boss)
	_level_completion_function = parent._on_complete_level

func start():
	spawner.start_spawner()

func stop():
	spawner.stop_spawner()

func get_player_spawn_location() -> Vector2:
	return $PlayerSpawnMarker.global_position

func _spawn_boss():
	var boss = boss_scene.instantiate()
	boss.connect("death",_level_completion_function)
	get_parent().add_child(boss)
