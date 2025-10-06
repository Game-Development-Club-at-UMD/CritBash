extends Node

var limb_scene_dir_address : String = "res://Limb Scenes/Scenes/"
const ENEMY = preload("uid://b6ic7wsg00p1j")
const PARENT_CREATURE = preload("uid://dr6x0l7rc5yuk")

var legs : Array[String]
var arms : Array[String]
var torsos : Array[String]
var heads : Array[String]

var fish : Array[String]
var minotaur : Array[String]
var hydra : Array[String]

func _ready() -> void:
	var dir = DirAccess.get_files_at(limb_scene_dir_address)
	
	# pack file names into array corresponding to limb type
	for file in dir:
		if file.containsn("debug"):
			continue
		else:
			if file.containsn("leg"):
				legs.append(file)
			elif file.containsn("arm"):
				arms.append(file)
			elif file.containsn("torso"):
				torsos.append(file)
			elif file.containsn("head"):
				heads.append(file)
			else:
				push_warning("File: ", file, " cannot be parsed to limb ")
			
			# pack file names into array 
			if file.containsn("fish"):
				fish.append(file)
			elif file.containsn("mino"):
				minotaur.append(file)
			elif file.containsn("hydra"):
				hydra.append(file)
			else:
				push_warning("File: ", file, " cannot be parsed to monster type")

#TODO: add functions to return PackedScenes of specific 

func get_new_enemy() -> Array[String]:
	return [
		limb_scene_dir_address + arms.pick_random(),
		limb_scene_dir_address + legs.pick_random(),
		limb_scene_dir_address + heads.pick_random(),
		limb_scene_dir_address + torsos.pick_random(),
	]

#func get_new_enemy() -> PackedScene:
	#var temp_enemy = load("res://Parent Creature/Scenes/parent_creature.tscn").instantiate()
	#get_tree().root.add_child(temp_enemy)
	#
	## create PackedScene holders for each body part type
	##var packed_arm = PackedScene.new()
	##var packed_leg = PackedScene.new()
	##var packed_head = PackedScene.new()
	##var packed_torso = PackedScene.new()
	#var packed_enemy = PackedScene.new()
	#
	## grab a random body part from all available types
	#var random_arm : String = limb_scene_dir_address + arms.pick_random()
	#var random_leg : String = limb_scene_dir_address + legs.pick_random()
	#var random_head : String = limb_scene_dir_address + heads.pick_random()
	#var random_torso : String = limb_scene_dir_address + torsos.pick_random()
	#
	#
	##var loaded_arm = 
	##var loaded_leg = 
	##var loaded_head = 
	##var loaded_torso = 
	#
	### pack random body parts into PackedScenes
	##packed_arm.pack(loaded_arm)
	##packed_leg.pack(loaded_leg)
	##packed_head.pack(loaded_head)
	##packed_torso.pack(loaded_torso)
	#
	## set temp_enemy's body parts to random body parts
	#temp_enemy.left_arm.set_body_part(load(random_arm))
	#temp_enemy.right_arm.set_body_part(load(random_arm))
	#temp_enemy.left_leg.set_body_part(load(random_leg))
	#temp_enemy.right_leg.set_body_part(load(random_leg))
	#temp_enemy.head.set_body_part(load(random_head))
	#temp_enemy.torso.set_body_part(load(random_torso))
	#
	## pack enemy once its body parts are set
	#packed_enemy.pack(temp_enemy)
	#temp_enemy.queue_free()
#
	## return packed enemy
	#return packed_enemy
