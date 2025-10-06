extends Node2D

@onready var sfx_volume: HSlider = $MarginContainer/VBoxContainer/SettingMenu/HBoxContainer3/SFXVolume
@onready var music_volume: HSlider = $MarginContainer/VBoxContainer/SettingMenu/HBoxContainer2/MusicVolume
@onready var main_volume: HSlider = $MarginContainer/VBoxContainer/SettingMenu/HBoxContainer/MainVolume
@onready var play: TextureButton = $MarginContainer/VBoxContainer/MainButtons/Play
@onready var settings: TextureButton = $MarginContainer/VBoxContainer/MainButtons/Settings
@onready var credits: TextureButton = $MarginContainer/VBoxContainer/MainButtons/Credits
@onready var quit: TextureButton = $MarginContainer/VBoxContainer/MainButtons/Quit
@onready var fullscreen: CheckBox = $MarginContainer/VBoxContainer/SettingMenu/Fullscreen
@onready var main_buttons: VBoxContainer = $MarginContainer/VBoxContainer/MainButtons
@onready var setting_menu: VBoxContainer = $MarginContainer/VBoxContainer/SettingMenu
@onready var back: TextureButton = $MarginContainer/VBoxContainer/SettingMenu/Back
@onready var credits_menu: VBoxContainer = $MarginContainer/VBoxContainer/CreditsMenu
@onready var credits_back: TextureButton = $MarginContainer/VBoxContainer/CreditsMenu/Back

var button_textures = [preload("uid://bnk17wb0merph"), preload("uid://bvbmec45drrsh"), preload("uid://ccvlnjv3ovsg3"), preload("uid://did5gkagterjm"), preload("uid://1f7f67yoaxph"), preload("uid://bk0dx36dm4nu1"), preload("uid://b5p5jq5bb80ly"), preload("uid://cw3uslkubdvnb"), preload("uid://ibkyxacbjeyv"), preload("uid://btwbcsixq6sa6"), preload("uid://c5hndo5jsxk5o"), preload("uid://bhbsjsqq2jnds"), preload("uid://bebdhx0codola"), preload("uid://hteefrnsp3ev"), preload("uid://c6lrqugok3tut"), preload("uid://d2ehyein1mdf6"), preload("uid://dw7pco2gwobf7"), preload("uid://bckbj02qqikdn"), preload("uid://cm2ko6dm4t4p8"), preload("uid://uoqpa2g3lgeb")]
@onready var button_array : Array[TextureButton] = [play, settings, credits, quit, back, credits_back]

func _ready() -> void:
	buttonTexture()
	play.grab_focus()
	fullscreen.button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	main_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("MUSIC")))
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

#func randomTexture():
	#return array.pick_random()


func setTextureButton(button, textureLoad) ->void:
	button.texture_normal = textureLoad

func buttonTexture():
	
	for button in button_array:
		button.texture_normal = button_textures.pick_random()
	
	
	#for i in range (0,7):
		#setTextureButton(bArray[i], randomTexture())
	

#func setTextureOnButtons():
	#settings.texture_normal
	#credits.texture_normal
 	#quit.texture_normal
	#back.texture_button
	#credits.texture_normal

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
