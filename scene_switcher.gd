extends Node

var packed_player_scene : PackedScene
var packed_enemy_scene : PackedScene

func _ready() -> void:
	#TODO: remove debug init loading
	save_player_scene(load("uid://dr6x0l7rc5yuk").instantiate())
	save_enemy_scene(load("uid://dr6x0l7rc5yuk").instantiate())


## TODO: typecast player to PlayerCreature
func save_player_scene(player : ParentCreature):
	var new_packed_scene : PackedScene = PackedScene.new()
	new_packed_scene.pack(player)
	packed_player_scene = new_packed_scene

func get_player_scene() -> PackedScene:
	return packed_player_scene

func get_enemy_scene() -> PackedScene:
	return packed_enemy_scene

## TODO: typecast enemy to EnemyCreature
func save_enemy_scene(enemy : ParentCreature):
	var new_packed_scene : PackedScene = PackedScene.new()
	new_packed_scene.pack(enemy)
	packed_enemy_scene = new_packed_scene

func switch_scene(scene_path : String):
	get_tree().change_scene_to_file(scene_path)
