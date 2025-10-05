class_name PlayerController extends Camera3D

@onready var rotation_helper: Node3D = $RotationHelper
@onready var face_ray_cast: RayCast3D = $RotationHelper/FaceRayCast

var mouse_sensitivity = 0.0018

## Emits when the player clicks on a node in group "interact", connected to a function by
## whatever root scene is currently active
signal player_action(limb_holder_clicked : Node)

func _ready() -> void:
	#face_ray_cast.enabled = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if face_ray_cast.is_colliding() and face_ray_cast.get_collider().is_in_group('show_on_hover'):
		if face_ray_cast.get_collider() != null:
			pass
			## this is where you'd set UI to be prompted to be visible
	
	if Input.is_action_just_pressed("interact"):
		if face_ray_cast.is_colliding() && face_ray_cast.get_collider().is_in_group("interact"):
			var node_clicked = face_ray_cast.get_collider().get_parent()
			player_action.emit(node_clicked)
			print(node_clicked, " was clicked")
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_helper.rotate_y(-event.relative.x * mouse_sensitivity)
		face_ray_cast.rotate_x(-event.relative.y * mouse_sensitivity)
