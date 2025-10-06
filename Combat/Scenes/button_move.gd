class_name ButtonInfo
extends TextureButton

signal sendMove(sentMove : Move)

@onready var label: Label = %Label
@onready var texture_rect: TextureRect = %TextureRect


var array = [preload("uid://bnk17wb0merph"), preload("uid://bvbmec45drrsh"), preload("uid://ccvlnjv3ovsg3"), preload("uid://did5gkagterjm"), preload("uid://1f7f67yoaxph"), preload("uid://bk0dx36dm4nu1"), preload("uid://b5p5jq5bb80ly"), preload("uid://cw3uslkubdvnb"), preload("uid://ibkyxacbjeyv"), preload("uid://btwbcsixq6sa6"), preload("uid://c5hndo5jsxk5o"), preload("uid://bhbsjsqq2jnds"), preload("uid://bebdhx0codola"), preload("uid://hteefrnsp3ev"), preload("uid://c6lrqugok3tut"), preload("uid://d2ehyein1mdf6"), preload("uid://dw7pco2gwobf7"), preload("uid://bckbj02qqikdn"), preload("uid://cm2ko6dm4t4p8"), preload("uid://uoqpa2g3lgeb")]


var move : Move 
var rNum : int

func _ready() -> void:
	setTextureButton(randomTexture())

func randomTexture():
	return array.pick_random()


func setTextureButton(textureLoad) ->void:
	texture_normal = textureLoad


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
	
