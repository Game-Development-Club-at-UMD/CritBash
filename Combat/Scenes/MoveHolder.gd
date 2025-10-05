extends Node


  # or whatever MoveHolder inherits from

var moveDict := {}  # Dictionary<String, Dictionary> for testing

# Add a move with title and icon
func add_dummy_moves() -> void:
	moveDict["Punch"] = {
		"title": "Punch",
		"icon": preload("res://IMG_6062.jpg")
	}
	moveDict["Kick"] = {
		"title": "Kick",
		"icon": preload("res://IMG_6062.jpg")
	}
	moveDict["Block"] = {
		"title": "Block",
		"icon": preload("res://IMG_6062.jpg")
	}
