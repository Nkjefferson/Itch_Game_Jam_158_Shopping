extends Node2D

@export var mob_scene : PackedScene

var spawner_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_music("res://assets/audio/House In a Forest Loop Reversed.ogg")
	generate_spawner_list()
	$EnemySpawners/SpawnTimer.start()
	spawn_enemy("hello")
	spawn_enemy("hello")
	spawn_enemy("hello")
	spawn_enemy("hello")

func generate_spawner_list():
	for spawner in $EnemySpawners.get_children():
		if spawner is Marker2D:
			spawner_list.append(spawner)

func spawn_enemy(enemy):
	var mob = mob_scene.instantiate()
	var spawn_location = spawner_list[randi()%spawner_list.size()].position
	mob.position = spawn_location
	print("adding mob at", spawn_location)
	add_child(mob)

func _on_spawn_timer_timeout():
	spawn_enemy("yo")
