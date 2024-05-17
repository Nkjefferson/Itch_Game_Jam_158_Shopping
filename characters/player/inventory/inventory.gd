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

var slots : Array[Card_Slot] = []

func _ready():
	var loadout : Array[PackedScene] = [Standard_Card,Piercing_Card,Triple_Card,Entangle_Card,Orbit_Card]
	for packed_card in loadout:
		if packed_card:
			var slot = Card_Slot.new()
			slot.card = packed_card
			var card_scene : Card = packed_card.instantiate()
			slot.refresh_amount = card_scene.get_refresh_count()
			slot.max_stack = card_scene.get_max_count()
			slot.count = card_scene.get_refresh_count()
			slots.append(slot)
			card_scene.queue_free()

func restock(index):
	if index >= 0 and index < slots.size(): 
		slots[index].count += slots[index].refresh_amount
		if slots[index].count > slots[index].max_stack:
			slots[index].count = slots[index].max_stack
		update_card_count.emit(index, slots[index].count)

func refresh_hotbar():
	for index in range(slots.size()):
		update_card_count.emit(index, slots[index].count)

func shoot(index):
	if slots[index].count > 0:
		slots[index].count -= 1
		update_card_count.emit(index, slots[index].count)
		return slots[index].card
	else:
		MusicManager.play_sound_effect(empty_slot_sound, 20)
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






 
