class_name DodgeButton
extends Node2D

@onready var label: Label = $Label
@onready var invuln_timer: Timer = $InvulnTimer

var isDodging : bool = false
var can_dodge : bool = false

signal dodgeStartPhase


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if can_dodge and Input.is_action_just_pressed("Dodge"):
		isDodging = true
		can_dodge = false
		invuln_timer.start()
		label.add_theme_color_override("font_color", Color(0.0, 0.951, 0.206, 0.5))
	


func startDodgePhase() -> void:
	can_dodge = true
	label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
	dodgeStartPhase.emit()


func updateCooldownTimer(dodgeLength : float) -> void:
	invuln_timer.wait_time = dodgeLength


func getIsDodging() -> bool:
	return isDodging


func setCanDodge(canDodge : bool):
	can_dodge = canDodge
	

func _on_invuln_timer_timeout() -> void:
	print("no longer invulnerable")
	isDodging = false
