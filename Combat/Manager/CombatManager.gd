class_name CombatManager extends Node3D

@onready var dodge_button: DodgeButton = %DodgeButton
@onready var player: Node3D = $Player
@onready var enemy: Enemy = %Enemy
@onready var combat_ui: CombatUI = %CombatUi


#TODO: have cleaner way to get each attack button, makes it easier to import resources to/grab resources from
#TODO: also, have some kind of CombatButton class



func _ready() -> void:
	dodge_button.visible = false
	combat_ui.visible = false
	#enemy.debug_limb_swapping()
	#player.debug_limb_swapping()
	dodge_button.connect("dodgeStartPhase", _on_dodge_timer_start)
	#TODO: make signal in class CombatButton to emit its held Move resource when its clicked
	#for button in buttons_arr:
		#button.connect('clicked', callMoveOnEnemy)
	enemy.connect("sendEnemyMove", callMoveOnPlayer)

	player.connect("sendMaxHealth", getPlayerMaxHealth)
	player.connect("sendPlayerMoveHolder", updateUIButtons)
	
	combat_ui.connect("connectThisBitch", connectButtonSignal)
	player.sendPlayerMoveHolder.emit(player.moveHolder)
	
	
	# give the player a moment to digest the scene before starting attack
	#TODO: make this make a bit more sense, maybe wait for player input?
	await get_tree().create_timer(3).timeout
	
	# do enemy attack here to start the cycle of dodging and whatnot
	dodge_button.startDodgePhase()
	start_enemy_attack()
	#TODO: add an actual attack telegraph here to give the player a better indication to dodge

## called when dodge timer starts in dodgeButton
func _on_dodge_timer_start():
	print("PLAYER START DODGING")
	dodge_button.visible = true

## called when dodge timer ends in dodgeButton, dodge_result is the boolean value representing the success
## of the player's dodge
func _on_dodge_timer_end(dodge_result : bool):
	print("PLAYER STOP DODGING")
	print('dodge outcome: ', dodge_result)
	dodge_button.visible = false
	enemy.SelectMove()


## called after the dodge timer ends, triggers enemy anims and either the player dodge or hit anims
## + triggers damage to player if they were hit
func callMoveOnPlayer(move : Move):
	dodge_button.setCanDodge(false)
	print("enemy calling move")
	# TODO: trigger enemy attack anims regardless of dodge outcome
	if dodge_button.getIsDodging():
		print("enemy misses player")
		# TODO: trigger player dodge animation here
		pass
	else:
		print("enemy hits player")
		# TODO: trigger player hit anims here, apply damage properly to player
		move.DoMove(player)
	# slight pause
	await get_tree().create_timer(2).timeout
	# allow player to make their attack
	start_player_attack()


func callMoveOnEnemy(moveToCall : Move):
	print("call this move: " + moveToCall.getName())
	combat_ui.visible = false
	moveToCall.DoMove(enemy)

func getPlayerMaxHealth(_pMaxHealth : int):
	pass

func start_player_attack():
	print("PLAYER CHOOSE ATTACK")
	combat_ui.visible = true
	dodge_button.visible = false
	#TODO: change this so its a variable time to attack?
	combat_ui.getCombatTimer().resetValue()
	await get_tree().create_timer(3).timeout
	end_player_attack()

func end_player_attack():
	print("end player attack phase")
	await get_tree().create_timer(1).timeout
	# restart attack loops here
	dodge_button.startDodgePhase()
	combat_ui.visible = false
	dodge_button.visible = true
	start_enemy_attack()


func start_enemy_attack():
	await get_tree().create_timer(2).timeout
	enemy.SelectMove()


func updateUIButtons(playerMHolder : MoveHolder):
	combat_ui.create_button_from_dict(playerMHolder)


func connectButtonSignal(button : ButtonInfo):
	button.connect("sendMove", callMoveOnEnemy)
