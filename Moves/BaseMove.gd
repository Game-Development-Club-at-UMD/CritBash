class_name Move
extends Resource

@export var name : String = ""
@export var texture : Texture2D

func getName() -> String:
	return name


func getTexture() -> Texture2D:
	return texture


@warning_ignore("unused_parameter")
func DoMove(target : ParentCreature) -> void:
	pass
