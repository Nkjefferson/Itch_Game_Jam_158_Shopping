extends Node2D

signal finished

@export var spawned_entities: Array[SpawnedEntity]

var spawners : Array[Marker2D]
var weighted_sum : float = 0.0
var spawn_step_rate : float = 0.0
var max_spawn_rate : float = 0.2
var spawns_remaining : int = 0
var _entity_cleanup_handler : Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spawn_entities():
	if(spawned_entities):
		var entity = spawned_entities[get_spawn_index()].entity.instantiate()
		var spawn_location = spawners[randi()%spawners.size()].global_position
		entity.global_position = spawn_location
		if _entity_cleanup_handler:
			entity.connect("death",_entity_cleanup_handler)
		get_parent().get_parent().add_child(entity)
	else:
		printerr("Failed to spawn entity: no entitys defined")
	spawns_remaining -= 1

func create_spawners(initial_spawn_rate:float, spawner_max_rate:float, spawner_step_rate:float, total_spawns:int, _on_entity_cleanup_handler:Callable, points:Array[Vector2]=[global_position], entities:Array[SpawnedEntity]=[]):
	$SpawnTimer.wait_time = initial_spawn_rate
	spawn_step_rate = spawner_step_rate
	max_spawn_rate = spawner_max_rate
	spawns_remaining = total_spawns
	_entity_cleanup_handler = _on_entity_cleanup_handler
	destroy_spawners()
	for point in points:
		var marker = Marker2D.new()
		marker.global_position = point
		spawners.append(marker)
		add_child(marker)
	if entities:
		spawned_entities = entities
	if spawned_entities:
		for entity in spawned_entities:
			weighted_sum += entity.spawn_weight

func get_spawn_index():
	var rand_val = randf_range(0.0,weighted_sum)
	var index = 0
	for i in spawned_entities.size():
		if !((rand_val - spawned_entities[i].spawn_weight) < 0):
			rand_val = rand_val - spawned_entities[i].spawn_weight
		else:
			index = i
			break
	return index

func start_spawner():
	$SpawnTimer.start()
	
func stop_spawner():
	$SpawnTimer.stop()

func destroy_spawners():
	for spawner in spawners:
		spawner.queue_free()
	spawners = []


func _on_spawn_timer_timeout():
	spawn_entities()
	if $SpawnTimer.wait_time - spawn_step_rate > max_spawn_rate:
		$SpawnTimer.wait_time -= spawn_step_rate
	if spawns_remaining <= 0:
		stop_spawner()
		finished.emit()
