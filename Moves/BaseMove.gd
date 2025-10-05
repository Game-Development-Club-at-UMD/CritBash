class_name Move
extends Resource

@export var name : String = ""
@export var sprite : Texture2D

func getName() -> String:
	return name


@warning_ignore("unused_parameter")
func DoMove(target : ParentCreature) -> void:
	pass
