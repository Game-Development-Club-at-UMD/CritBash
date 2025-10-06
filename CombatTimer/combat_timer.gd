class_name CombatTimer extends Node2D

@onready var timer = $Timer
@onready var progressbar = $ProgressBar

signal progressDepleted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = progressbar.max_value
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	progressbar.value = timer.time_left


func _on_progress_bar_value_changed(value: float) -> void:
	if value == 0:
		progressDepleted.emit()


func setMaxValue(maxValue : float) -> void:
	progressbar.max_value = maxValue

func resetValue():
	progressbar.value = progressbar.max_value
	timer.start()
