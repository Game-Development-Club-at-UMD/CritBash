class_name AttackMove
extends Move

@export var Damage_Value : int = 0
@export_enum("None", "DamageAtMaxHealth") var modifier_type : int


var modifier : Modifier = Modifier.new()

func DoMove(target : ParentCreature) -> void:
	Damage_Value = modifier.apply_modifier(modifier_type, Damage_Value)
	target.subtractHealth(Damage_Value)
