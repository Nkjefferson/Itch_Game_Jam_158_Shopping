extends Node2D
class_name Stage

@export var points : Array[Vector2] = [Vector2(-70,279),Vector2(816,-73),Vector2(1386,81),Vector2(304,856)]
@export var spawner_scene : PackedScene = preload("res://environment/spawner/spawner.tscn")
@export var spawned_entities: Array[SpawnedEntity]

var spawner
var spawner_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner = spawner_scene.instantiate()
	self.add_child(spawner)

func load_level(parent):
	spawner.create_spawners(3.0,0.75,0.05,parent._on_enemy_death,points,spawned_entities)

func start():
	spawner.start_spawner()

func stop():
	spawner.stop_spawner()
