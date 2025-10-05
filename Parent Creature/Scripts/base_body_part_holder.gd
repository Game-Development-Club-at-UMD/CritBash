@abstract class_name BaseBodyPartHolder extends Node3D

## Body part stored in holder
@export var body_part : BaseBodyPart

## Sets and instantiates a new body part node
@abstract func set_body_part(new_part : PackedScene)

## Returns current body part node
@abstract func get_body_part() -> BaseBodyPart
