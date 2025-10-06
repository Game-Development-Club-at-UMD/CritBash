class_name Enemy extends ParentCreature

signal sendEnemyMove(emittedMove : Move)

var rNum : int


func _ready() -> void:
	scale = Vector3(5, 5, 5)
	super._ready()
	if SceneSwitcher.get_enemy_scene() == null:
		#TODO: replace this with SceneSwitcher.getRandomEnemy()
		loadLimbsFromPaths(CreatureCreator.get_new_enemy())
	else:
		load_data_from_scene_switcher(SceneSwitcher.get_enemy_scene())
		


## Random Selection of one of the current moves	
func SelectMove():
	rNum = randi_range(1, getMovesHolder().moveDict.size())
	sendEnemyMove.emit(getMovesHolder().getMoveFromDict("Move"+ str(rNum)))
