extends Node2D

signal update_card_count(index, count)
signal update_gold_amount(amount)

var gold = 10

@export var Standard_Card : PackedScene
@export var Piercing_Card : PackedScene
@export var Triple_Card : PackedScene
@export var Entangle_Card : PackedScene
@export var Orbit_Card : PackedScene
@export var empty_slot_sound : Resource = load("res://assets/audio/sound_effects/Bubble.wav")

var loadout : Array[PackedScene]

var slots : Array[CardSlot] = []

func _ready():
	loadout = [Standard_Card,Piercing_Card,Triple_Card,Entangle_Card,Orbit_Card]
	for packed_card in loadout:
		if packed_card:
			var slot = CardSlot.new()
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
	if slots.size() > index and slots[index].count > 0:
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






 
