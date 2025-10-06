extends Node3D
class_name ParentCreature

@warning_ignore("unused_signal")
signal sendPlayerMoveHolder(mHolder : MoveHolder)

@onready var MAX_HEALTH: int
@onready var current_health: int
@onready var damage: int

## TorsoHolder for the creature's Torso object
@onready var torso: TorsoHolder = $Torso
## LimbHolder for creature's left arm Limb object
@onready var left_arm: LimbHolder = $LeftArm
## LimbHolder for creature's right arm Limb object
@onready var right_arm: LimbHolder = $RightArm
## LimbHolder for creature's left leg Limb object
@onready var left_leg: LimbHolder = $LeftLeg
## LimbHolder for creature's right leg Limb object
@onready var right_leg: LimbHolder = $RightLeg
## LimbHolder for creature's head Limb object
@onready var head: LimbHolder = $Head

## Arayy of LimbHolders for each nontorso holder
@onready var limb_holders : Array[LimbHolder] = [left_arm, right_arm, left_leg, right_leg, head]
@onready var label_3d: Label3D = $Label3D

## Array of LimbHolder transforms for each body part
var transforms : Dictionary[String, Transform3D]

var moveHolder : MoveHolder = MoveHolder.new()

## Connects signals from BodyPartHolder nodes to their respective functions
func _ready() -> void:
	@warning_ignore("standalone_expression")
	torso.connect("instancing_new_torso", _on_new_torso_part_instanced)
	for holder in limb_holders:
		holder.connect("instancing_new_limb", _on_new_limb_part_instanced)


#func _process(_delta: float) -> void:
	#if Input.is_action_just_released("ui_accept"):
		#debug_limb_swapping()
	#
	#MAX_HEALTH = current_health

## Sets the transform of each LimbHolder node
func _on_new_torso_part_instanced(new_torso : Torso):
	transforms = new_torso.get_limb_positions()
	left_arm.set_transform(transforms.get("LeftArm"))
	right_arm.set_transform(transforms.get("RightArm"))
	left_leg.set_transform(transforms.get("LeftLeg"))
	right_leg.set_transform(transforms.get("RightLeg"))
	head.set_transform(transforms.get("Head"))
	

@warning_ignore("unused_parameter")
func _on_new_limb_part_instanced(new_limb : Limb):
	pass

func debug_limb_swapping():
	for holder in limb_holders as Array[BaseBodyPartHolder]:
		if holder.name != "Head":
			holder.set_body_part(load("res://Limb Scenes/Scenes/DebugLimb.tscn"))
		else:
			holder.set_body_part(load("res://Limb Scenes/Scenes/DebugHead.tscn"))
		getLimbResource(holder)
	torso.set_body_part(load("res://Limb Scenes/Scenes/DebugTorso.tscn"))
	getLimbResource(torso)
	addMovesToMoveDict()
	setMaxHealth()

func load_data_from_scene_switcher(packed_scene : PackedScene):
	# instantiate the PackedScene
	var loaded_scene : ParentCreature = packed_scene.instantiate() as ParentCreature
	var packed_body_part : PackedScene = PackedScene.new()
	var matched_holder : BaseBodyPartHolder
	# add player scene to the tree so we can actually change its data
	#get_tree().root.add_child(loaded_scene)
	get_tree().root.add_child.call_deferred(loaded_scene)
	for loaded_holder in loaded_scene.get_children():
		# grab the player-equivalent BodyPartHolder
		matched_holder = get_node(String(loaded_holder.name)) as BaseBodyPartHolder
		# pack the loaded body part into a PackedScene to pass into the set_body_part() function
		if loaded_holder.get_body_part() == null:
			push_warning("you're trying to pull data from a null limb, dumbass")
		else:
			packed_body_part.pack(loaded_holder.get_body_part())
			# pass in value to matched BodyPartHolder
			matched_holder.set_body_part(packed_body_part)
	# NUKE the loaded scene off the face of the earth
	loaded_scene.queue_free()
	addMovesToMoveDict()
	
	for holder in limb_holders as Array[BaseBodyPartHolder]:
		getLimbResource(holder)
	
	getLimbResource(torso)
	addMovesToMoveDict()
	setMaxHealth()

#region getters and setters
func getLimbResource(holder : BaseBodyPartHolder):
	var bpr: BodyPartResource = holder.get_body_part().get_body_part_resource()
	setBPRCurrentHealth(bpr)
	setBPRDamage(bpr)
	
	
func setBPRCurrentHealth(bpr : BodyPartResource):
	current_health += bpr.getPartHealth()
	
	
func setBPRDamage(bpr : BodyPartResource):
	damage += bpr.getPartAttack()


func setMaxHealth():
	MAX_HEALTH = current_health
	label_3d.text = str(current_health)
	print(label_3d.text)
	
func getMaxHealth() -> int:
	return MAX_HEALTH
	
	
func getCurrentHealth() -> int:
	return current_health
	
	
func getDamage() -> int:
	return damage


##Adds all moves from limbs to a dictionary in moveHolder
func addMovesToMoveDict():
	#Clear previous moves in dict
	moveHolder.clearDict()
	#Go throuh all limbs and add their moves to the moveDict
	for child in get_children():
		if child is BaseBodyPartHolder:
			if !moveHolder.checkIfValueExists(child.get_body_part().get_body_part_resource().getMove()):
				moveHolder.addtoMoveDict("Move" + str(moveHolder.moveDict.size() + 1),child.get_body_part().get_body_part_resource().getMove())

# Subtracts `val` to current health.
func subtractHealth(val: int) -> void:
	current_health = clamp(getCurrentHealth() - val, 0, MAX_HEALTH)
	label_3d.text = str(current_health)

## Returns the dictionary in moveHolder
func getMovesHolder() -> MoveHolder:
	return moveHolder

#endregion
