class_name Modifier

#var Multipler : float = 1.5

enum ModifierType {
	NONE, DAMAGEATMAXHEALTH
}

func DamageAtMaxHealth(damage : int):
	damage = damage * 2
	return damage
	
func apply_modifier(mod_type: int, damage: int) -> int:
	match mod_type:
		ModifierType.DAMAGEATMAXHEALTH:
			return DamageAtMaxHealth(damage)
		_:
			return damage
