class_name Enemy extends ParentCreature

signal sendEnemyMove(emittedMove : Move)

var rNum : int

## Random Selection of one of the current moves	
func SelectMove():
	rNum = randi_range(1, getMovesHolder().moveDict.size())
	sendEnemyMove.emit(getMovesHolder().getMoveFromDict("Move"+ str(rNum)))
	print(getMovesHolder().getMoveFromDict("Move"+ str(rNum)).getName())

func SendDamageToPlayer() -> void:
	pass

#func _process(_delta: float) -> void:
	#if Input.is_action_just_released("ui_accept"):
		#SelectMove()
		#
