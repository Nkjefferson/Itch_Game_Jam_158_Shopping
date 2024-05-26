class_name Rarity

enum CardRarity {COMMON,UNCOMMON,RARE,NONE}

static func get_refresh_count(rarity: CardRarity) -> int:
	match rarity:
		CardRarity.COMMON:
			return 12
		CardRarity.UNCOMMON:
			return 6
		CardRarity.RARE:
			return 1
		_:
			return 0

static func get_max_count(rarity: CardRarity) -> int:
	match rarity:
		CardRarity.COMMON:
			return 35
		CardRarity.UNCOMMON:
			return 18
		CardRarity.RARE:
			return 5
		_:
			return 0

static func get_value(rarity: CardRarity) -> int:
	match rarity:
		CardRarity.COMMON:
			return 100
		CardRarity.UNCOMMON:
			return 200
		CardRarity.RARE:
			return 400
		_:
			return 0

static func from_string(rarity_string: String) -> CardRarity:
	var test_name = rarity_string.to_upper()
	match test_name:
		"COMMON":
			return CardRarity.COMMON
		"UNCOMMON":
			return CardRarity.UNCOMMON
		"RARE":
			return CardRarity.RARE
		_:
			return CardRarity.NONE
