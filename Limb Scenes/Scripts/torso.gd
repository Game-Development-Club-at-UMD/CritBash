class_name Torso extends BaseBodyPart

## Marker3D for left arm connection point
@export var left_arm : Marker3D
## Marker3D for right arm connection point
@export var right_arm : Marker3D
## Marker3D for left leg connection point
@export var left_leg : Marker3D
## Marker3D for right leg connection point
@export var right_leg : Marker3D
## Marker3D for head connection point
@export var head : Marker3D

## Returns position, rotation, and scalar data for limb connection points
## as a dictionary of Transform3D's
func get_limb_positions() -> Dictionary[String, Transform3D]:
	return {
		"LeftArm": left_arm.transform,
		"RightArm": right_arm.transform,
		"LeftLeg": left_leg.transform,
		"RightLeg": right_leg.transform,
		"Head": head.transform
	}
