class_name Player extends ParentCreature

@onready var currentHealth : int = current_health

signal sendMaxHealth(pMaxHealth : int)
signal sendCurrentHealth(pCurrentHealth : int)


#Function to alter health
func takeDamage(enemyDamage : int) -> void:
	subtractHealth(enemyDamage)
	
	
func updateCurrentHealthUI() -> void:
	sendCurrentHealth.emit(getCurrentHealth())



func _ready() -> void:
	#sendMaxHealth.emit(getMaxHealth())
	#sendCurrentHealth.emit(getCurrentHealth())
	pass

func _process(delta: float) -> void:	
	#debug()
	pass
	
func debug() -> void:
	if Input.is_action_just_released("ui_accept"):
		debug_limb_swapping()
		sendMaxHealth.emit(getMaxHealth())
		sendCurrentHealth.emit(getCurrentHealth())
