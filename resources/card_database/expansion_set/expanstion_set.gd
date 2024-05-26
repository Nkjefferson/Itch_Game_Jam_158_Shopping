class_name ExpansionSet

enum Expansion {FURY_OF_THE_ELEMENTS,TWISTED_ARCANUM,MONARCHS_OF_THE_FOREST,SPACE_CRUSADERS,NONE}

static func display_string(expac: Expansion) -> String:
	match expac:
		Expansion.FURY_OF_THE_ELEMENTS:
			return "Fury of the Elements"
		Expansion.TWISTED_ARCANUM:
			return "Twisted Arcanum"
		Expansion.MONARCHS_OF_THE_FOREST:
			return "Monarchs of the Forest"
		Expansion.SPACE_CRUSADERS:
			return "Space Crusaders"
		_:
			return ""

static func from_string(string_name:String) -> Expansion:
	var test_name = string_name.to_upper()
	match test_name:
		"FURY_OF_THE_ELEMENTS":
			return Expansion.FURY_OF_THE_ELEMENTS
		"TWISTED_ARCANUM":
			return Expansion.TWISTED_ARCANUM
		"MONARCHS_OF_THE_FOREST":
			return Expansion.MONARCHS_OF_THE_FOREST
		"SPACE_CRUSADERS":
			return Expansion.SPACE_CRUSADERS
		_:
			return Expansion.NONE
