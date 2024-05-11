extends Node2D

@export var Basic_Card : PackedScene
@export var max_basic_cards : int = 52
@export var Piercing_Card : PackedScene
@export var max_piercing_cards : int = 10
@export var Triple_Card : PackedScene
@export var max_triple_cards : int = 5

class Card_Slot:
	var card : PackedScene
	var count : int
	
var Slot0
var Slot1
var Slot2
var Slot3
var Slot4
var loadout

func _ready():
	Slot0 = Card_Slot.new()
	Slot0.card = Basic_Card
	Slot0.count = max_basic_cards
	
	Slot1 = Card_Slot.new()
	Slot1.card = Piercing_Card
	Slot1.count = max_piercing_cards
	
	Slot2 = Card_Slot.new()
	Slot2.card = Triple_Card
	Slot2.count = max_triple_cards
	
	loadout = [Slot0, Slot1, Slot2, Slot3, Slot4]

func shoot(index, spawn_position, spawn_angle):
	if loadout[index].count > 0:
		var c = loadout[index].card.instantiate()
		self.get_parent().add_child(c)
		c.spawn(spawn_position, spawn_angle)
		loadout[index].count -= 1
	else:
		print("no bullets left")





 
