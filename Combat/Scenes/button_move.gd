class_name ButtonInfo
extends Button

signal sendMove(sentMove : Move)

@onready var label: Label = %Label
@onready var texture_rect: TextureRect = %TextureRect

var move : Move 


func setText() -> void:
	label.text = move.getName()


func setTexture() -> void:
	texture_rect.texture = move.getTexture()


func setMove(newMove : Move):
	move = newMove


func setupVisuals() -> void:
	if !move:
		push_error("There is no move resource in this button")
		return
	
	setText()
	setTexture()


func _on_pressed() -> void:
	sendMove.emit(move)
