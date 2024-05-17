class_name Rarity

enum CardRarity {COMMON,UNCOMMON,RARE}

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
