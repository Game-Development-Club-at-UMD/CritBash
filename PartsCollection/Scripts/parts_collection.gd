class_name PartsCollection extends Node3D

var enemy : ParentCreature
@onready var enemy_holder: Node3D = $EnemyHolder

@export var player_controller : PlayerController

func _ready() -> void:
	player_controller.connect('player_action', _on_player_clicked_node)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		debug()
	if Input.is_action_just_pressed("ui_down"):
		SceneSwitcher.switch_scene("res://Main Menu/main_menu.tscn")

func instance_new_enemy(new_enemy : PackedScene):
	var instanced_enemy = new_enemy.instantiate()
	
	if !instanced_enemy is ParentCreature:
		push_error("Error in node ", name, ": Attempted to instance node of type ", instanced_enemy.get_class())
		instanced_enemy.queue_free()
		return null
	
	self.add_child(instanced_enemy)
	#TODO: fix enemy spawning in at the correct position/rotation
	enemy_holder.add_child(instanced_enemy)
	instanced_enemy.global_transform = enemy_holder.global_transform
	
	
	if enemy != null:
		enemy.queue_free()
	enemy = instanced_enemy
	enemy.global_transform = enemy_holder.global_transform


func _on_player_clicked_node(clicked_body_part : Node):
	# this function is AWFUL i am so sorry - aria
	
	# confirm clicked node is of proper type to do the rest of this bs
	if clicked_body_part is BaseBodyPart:
		# grab the clicked node's parent
		var clicked_body_part_holder : BaseBodyPartHolder = clicked_body_part.get_parent() as BaseBodyPartHolder
		# pull the saved player scene from the SceneSwitcher global
		var player_scene : ParentCreature = SceneSwitcher.get_player_scene().instantiate() as ParentCreature
		# add player scene to the tree so we can actually change its data
		get_tree().root.add_child(player_scene)
		# grab the player-equivalent BodyPartHolder that was clicked on the enemy (left arm clicked -> grab left arm)
		var matched_holder : BaseBodyPartHolder = player_scene.find_child(clicked_body_part_holder.name) as BaseBodyPartHolder
		# pack the clicked body part into a PackedScene to pass into the set_body_part() function
		var packed_body_part : PackedScene = PackedScene.new()
		packed_body_part.pack(clicked_body_part)
		# pass in value to player's BodyPartHolder
		matched_holder.set_body_part(packed_body_part)
		# save altered player scene to SceneSwitcher
		SceneSwitcher.save_player_scene(player_scene)
		# NUKE this off the face of the earth
		player_scene.queue_free()
		
	else:
		pass
		#var player_scene : ParentCreature = SceneSwitcher.get_player_scene().instantiate() as ParentCreature
		##TODO: add multiplier here
		#SceneSwitcher.save_player_scene(player_scene)

func debug():
	# initialize an enemy to pass instance in the ACTUAL instance method
	var debug_enemy : Node = load("res://Parent Creature/Scenes/parent_creature.tscn").instantiate()
	
	# just adding the creature to the scene tree
	get_tree().root.add_child(debug_enemy)
	
	# initializing all body parts with values
	debug_enemy.torso.set_body_part(load("res://Limb Scenes/Scenes/DebugTorso.tscn"))
	for holder in debug_enemy.limb_holders:
		if holder.name != "Head":
			holder.set_body_part(load("res://Limb Scenes/Scenes/DebugLimb.tscn"))
		else:
			holder.set_body_part(load("res://Limb Scenes/Scenes/DebugHead.tscn"))
	
	# compressing scene back into a PackedScene
	##WE HAVE TO DECLARE THE NEW PACKED SCENE AND THEN PACK IT ON A SEPARATE LINE !!!
	##INCORRECT: var packed_enemy = PackedScene.new().pack(debug_enemy)
	## ^ if you do this on the same line, the function .pack() returns an Error object into the packed_enemy variable
	var packed_enemy : PackedScene = PackedScene.new()
	packed_enemy.pack(debug_enemy)
	debug_enemy.queue_free()
	# passing debug packed scene to the ACTUAL instancer
	instance_new_enemy(packed_enemy)
	
