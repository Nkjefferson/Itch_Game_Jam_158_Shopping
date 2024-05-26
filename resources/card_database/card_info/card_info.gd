class_name CardInfo

var card_name : String = ""
var pack : ExpansionSet.Expansion = ExpansionSet.Expansion.NONE
var rarity : Rarity.CardRarity = Rarity.CardRarity.NONE
var description : String = ""
var speed : int = 0
var damage : int = 0
var value_override : int = 0
var refresh_count_override: int = -1
var max_count_override: int = -1
var throw_sound: Resource = preload("res://assets/audio/sound_effects/Card_Throw.wav")
var wall_hit_sound: Resource = preload("res://assets/audio/sound_effects/Card_Hit_Wall.wav")
var enemy_hit_sound: Resource = preload("res://assets/audio/sound_effects/card_hit_enemy.wav")
var sprite: Resource


func print():
	print("Name:",card_name)
	print("Expansion Set:",ExpansionSet.display_string(pack))
	print("Rarity:",rarity)
	print("Description:",description)
	print("Speed:",speed)
	print("Damage:",damage)
	print("Value:",value_override)
	print("Refresh Count:",refresh_count_override)
	print("Max Count:",max_count_override)
