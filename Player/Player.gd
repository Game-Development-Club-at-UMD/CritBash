class_name Player extends ParentCreature

@onready var currentHealth : int = current_health

signal sendMaxHealth(pMaxHealth : int)
signal sendCurrentHealth(pCurrentHealth : int)


func _ready() -> void:
	super._ready()
	if SceneSwitcher.get_player_scene() == null:
		#TODO: replace this with SceneSwitcher.getDefaultPlayer()
		debug_limb_swapping()
	else:
		load_data_from_scene_switcher(SceneSwitcher.get_player_scene())


#Function to alter health
func takeDamage(enemyDamage : int) -> void:
	subtractHealth(enemyDamage)
	
	
func updateCurrentHealthUI() -> void:
	sendCurrentHealth.emit(getCurrentHealth())


func _process(_delta: float) -> void:	
	#debug()
	pass
	
func debug() -> void:
	if Input.is_action_just_released("ui_accept"):
		debug_limb_swapping()
		sendMaxHealth.emit(getMaxHealth())
		sendCurrentHealth.emit(getCurrentHealth())
