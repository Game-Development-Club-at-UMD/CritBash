extends Node2D

@onready var sfx_volume: HSlider = $MarginContainer/VBoxContainer/SettingMenu/HBoxContainer3/SFXVolume
@onready var music_volume: HSlider = $MarginContainer/VBoxContainer/SettingMenu/HBoxContainer2/MusicVolume
@onready var main_volume: HSlider = $MarginContainer/VBoxContainer/SettingMenu/HBoxContainer/MainVolume
@onready var play: Button = $MarginContainer/VBoxContainer/MainButtons/Play
@onready var settings: Button = $MarginContainer/VBoxContainer/MainButtons/Settings
@onready var credits: Button = $MarginContainer/VBoxContainer/MainButtons/Credits
@onready var quit: Button = $MarginContainer/VBoxContainer/MainButtons/Quit
@onready var fullscreen: CheckBox = $MarginContainer/VBoxContainer/SettingMenu/Fullscreen
@onready var main_buttons: VBoxContainer = $MarginContainer/VBoxContainer/MainButtons
@onready var setting_menu: VBoxContainer = $MarginContainer/VBoxContainer/SettingMenu
@onready var back: Button = $MarginContainer/VBoxContainer/SettingMenu/Back
@onready var credits_menu: VBoxContainer = $MarginContainer/VBoxContainer/CreditsMenu
@onready var credits_back: Button = $MarginContainer/VBoxContainer/CreditsMenu/Back


func _ready() -> void:
	play.grab_focus()
	fullscreen.button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	main_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("MUSIC")))
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _on_play_pressed() -> void:
	print('change scene to tutorial scene')
	SceneSwitcher.switch_scene("res://PartsCollection/Scenes/parts-collection.tscn")

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	setting_menu.visible = true
	back.grab_focus()

func _on_credits_pressed() -> void:
	main_buttons.visible = false
	credits_menu.visible = true
	credits_back.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	main_buttons.visible = true
	if setting_menu.visible:
		setting_menu.visible = false
		settings.grab_focus()
	if credits_menu.visible:
		credits_menu.visible = false
		credits.grab_focus()


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _on_main_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"), value)

func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
