extends Node3D
class_name ParentCreature

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

## Array of LimbHolder transforms for each body part
var transforms : Dictionary[String, Transform3D]

var moveHolder : MoveHolder = MoveHolder.new()

## Connects signals from BodyPartHolder nodes to their respective functions
func _ready() -> void:
	torso.connect("instancing_new_torso", _on_new_torso_part_instanced)
	for holder in limb_holders:
		holder.connect("instancing_new_limb", _on_new_limb_part_instanced)


func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		debug_limb_swapping()
	
	MAX_HEALTH = current_health

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
	print(MAX_HEALTH)
	print(current_health)
	print(damage)	
	
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

## Returns the dictionary in moveHolder
func getMovesHolder() -> MoveHolder:
	return moveHolder
	
