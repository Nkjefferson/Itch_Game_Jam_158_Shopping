extends Node

var default_throw_sound : Resource = preload("res://assets/audio/sound_effects/Card_Throw.wav")
var default_wall_hit_sound : Resource = preload("res://assets/audio/sound_effects/Card_Hit_Wall.wav")
var default_enemy_hit_sound : Resource = preload("res://assets/audio/sound_effects/card_hit_enemy.wav")

var card_dict = {}
var cards = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	card_dict = read_card_database("res://resources/card_database/data/cards.json")
	if card_dict:
		for card in card_dict.keys():
			var current_card = card_dict[card]
			cards[card] = create_card(current_card["Name"],
			ExpansionSet.from_string(current_card["Expansion"]),
			Rarity.from_string(current_card["Rarity"]),
			current_card["Description"],
			int(current_card["Speed"]),
			int(current_card["Damage"]),
			int(current_card["Refresh_Count"]),
			int(current_card["Max_Count"]),
			current_card["Throw_Sound"],
			current_card["Wall_Hit_Sound"],
			current_card["Enemy_Hit_Sound"]
			)
			print(card,":")
			cards[card].print()
	else:
		printerr("Failed to load card database")

func read_card_database(file_path):
	var card_data
	if !FileAccess.file_exists(file_path):
		printerr("Card information file does not exists: ",file_path)
		return null
	var card_file = FileAccess.open("res://resources/card_database/data/cards.json", FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(card_file.get_as_text())
	if error == OK:
		card_data = json.data
		if card_data is Dictionary:
			print("Dictionary Found")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", card_file.get_as_text(), " at line ", json.get_error_line())
		return null
	card_file.close()
	return card_data


func create_card(card_name:String,
				 expac:ExpansionSet.Expansion,
				 rarity : Rarity.CardRarity,
				 description: String,
				 speed : int,
				 damage : int,
				 refresh_count_override = -1,
				 max_count_override = -1,
				 throw_sound: String = "",
				 wall_hit_sound: String = "",
				 enemy_hit_sound: String = "") -> CardInfo:
	var card_info = CardInfo.new()
	if !card_name:
		printerr("Card must have a name")
		return null
	card_info.card_name = card_name
	card_info.pack = expac
	card_info.rarity = rarity
	card_info.description = description
	card_info.speed = speed
	card_info.damage = damage
	card_info.refresh_count_override = refresh_count_override
	card_info.max_count_override = max_count_override
	if throw_sound != "":
		card_info.throw_sound = load(throw_sound)
	if wall_hit_sound != "":
		card_info.wall_hit_sound = load(wall_hit_sound)
	if enemy_hit_sound != "":
		card_info.enemy_hit_sound = load(enemy_hit_sound)
	return card_info
