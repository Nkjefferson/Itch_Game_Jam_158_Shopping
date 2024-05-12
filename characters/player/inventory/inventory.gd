extends Node2D

signal update_card_count(index, count)
signal update_gold_amount(amount)

var gold = 10

@export var Standard_Card : PackedScene
@export var max_basic_cards : int = 52
@export var Piercing_Card : PackedScene
@export var refresh_piercing_cards : int = 10
@export var max_piercing_cards : int = 50
@export var Triple_Card : PackedScene
@export var refresh_triple_cards : int = 5
@export var max_triple_cards : int = 25
@export var Entangle_Card : PackedScene
@export var refresh_entangle_cards : int = 5
@export var max_entangle_cards : int = 15
@export var Orbit_Card : PackedScene
@export var refresh_orbit_cards : int = 5
@export var max_orbit_cards : int = 25
@export var empty_slot_sound : Resource = load("res://assets/audio/sound_effects/Bubble.wav")

class Card_Slot:
	var card : PackedScene
	var max_stack : int
	var count : int
	var refresh_amount : int

var Slot0
var Slot1
var Slot2
var Slot3
var Slot4
var loadout

func _ready():
	Slot0 = Card_Slot.new()
	Slot0.card = Standard_Card
	Slot0.max_stack = max_basic_cards
	Slot0.count = Slot0.max_stack
	Slot0.refresh_amount = max_basic_cards
	
	Slot1 = Card_Slot.new()
	Slot1.card = Piercing_Card
	Slot1.refresh_amount = refresh_piercing_cards
	Slot1.max_stack = max_piercing_cards
	Slot1.count = Slot1.refresh_amount
	
	Slot2 = Card_Slot.new()
	Slot2.card = Triple_Card
	Slot2.refresh_amount = refresh_triple_cards
	Slot2.max_stack = max_triple_cards
	Slot2.count = Slot2.refresh_amount
	
	Slot3 = Card_Slot.new()
	Slot3.card = Entangle_Card
	Slot3.refresh_amount = refresh_entangle_cards
	Slot3.max_stack = max_entangle_cards
	Slot3.count = Slot3.refresh_amount
	
	Slot4 = Card_Slot.new()
	Slot4.card = Orbit_Card
	Slot4.refresh_amount = refresh_orbit_cards
	Slot4.max_stack = max_orbit_cards
	Slot4.count = Slot4.refresh_amount
	
	loadout = [Slot0, Slot1, Slot2, Slot3, Slot4]

func restock(index):
	if index >= 0 and index < loadout.size(): 
		loadout[index].count += loadout[index].refresh_amount
		if loadout[index].count > loadout[index].max_stack:
			loadout[index].count = loadout[index].max_stack
		update_card_count.emit(index, loadout[index].count)

func refresh_hotbar():
	for index in range(loadout.size()):
		update_card_count.emit(index, loadout[index].count)

func shoot(index):
	if loadout[index].count > 0:
		loadout[index].count -= 1
		update_card_count.emit(index, loadout[index].count)
		return loadout[index].card
	else:
		MusicManager.play_sound_effect(empty_slot_sound)
		return null

func add_gold(amount):
	gold += amount
	update_gold_amount.emit(gold)
	
func pay_gold(amount):
	gold = clamp(gold-amount,0, gold)
	update_gold_amount.emit(gold)
	
func check_funds(cost):
	if (gold - cost) < 0:
		return false
	else:
		return true 






 
