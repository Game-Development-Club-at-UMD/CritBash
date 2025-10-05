class_name MoveHolder extends Node

var moveDict: Dictionary[String, Move]


func addtoMoveDict(moveName : String, newMove : Move):
	moveDict.get_or_add(moveName, newMove)


func getMoveFromDict(key : String) -> Move:
	return moveDict[key]


func clearDict():
	moveDict.clear()

##Returns a boolean based on if a Move resource exists as a value in the moveDict
func checkIfValueExists(newMove : Move) -> bool:
	for key in moveDict.keys():
		if moveDict[key] == newMove:
			return true
	return false
