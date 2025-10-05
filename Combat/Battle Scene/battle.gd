extends Node

@export var enemy: Resource = null

var current_player_health= 0  
var current_enemy_health = 0

signal changeTurn
signal textbox_closed 


func _ready():
	
	displaytext("a wild p-whizz has appeared!!!!!!! ")
	
	
	
	await self.textbox_closed 
	
	current_enemy_health = enemy.health 
	
func set_health(health, max_health, progress_bar): 
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP:%d/%d" % [health, max_health]	 
	
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Textbox.hide()
		emit_signal("textbox_closed")
	
func displaytext(text):
	$Textbox.show()
	$Textbox/Label.text = text	
	
func enemy_turn():
	displaytext("the enemy slapped you for 20 damage")
	current_player_health = max(0,current_player_health - enemy.damage )
	await self.textbox_closed
		
	

	


func _on_attack_1_pressed():
	set_health(current_enemy_health, enemy.health, $VBoxContainer/EnemyHealth)
	await self.textbox_closed
	
	
	enemy_turn()
	


func _on_attack_2_pressed():
	set_health(current_enemy_health, enemy.health, $VBoxContainer/EnemyHealth)
	await self.textbox_closed
		
	enemy_turn()
	


func _on_attack_3_pressed():
	set_health(current_enemy_health, enemy.health, $VBoxContainer/EnemyHealth)
	await self.textbox_closed
		
	enemy_turn()
	
	


func _on_attack_4_pressed():
	set_health(current_enemy_health, enemy.health, $VBoxContainer/EnemyHealth)
	await self.textbox_closed
		
	enemy_turn()
	
	
	
