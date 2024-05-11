extends Node2D

signal update_card_count(index, count)

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
	
	Slot3 = Card_Slot.new()
	Slot3.card = Basic_Card
	Slot3.count = 0
	
	Slot4 = Card_Slot.new()
	Slot4.card = Basic_Card
	Slot4.count = 0
	
	loadout = [Slot0, Slot1, Slot2, Slot3, Slot4]


func refresh_hotbar():
	for index in range(loadout.size()):
		update_card_count.emit(index, loadout[index].count)

func shoot(index):
	if loadout[index].count > 0:
		loadout[index].count -= 1
		update_card_count.emit(index, loadout[index].count)
		return loadout[index].card
	else:
		print("no bullets left")
		return null






 
