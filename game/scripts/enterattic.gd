extends Area3D

@export var player : Node3D
var camera_node: Camera3D
var transition_speed = 2.0
#@onready var animations : AnimationPlayer = $"../CameraAnimator"

@onready var camMain = %Player.camMain
@onready var camAttic = %Player.camAttic

func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		%Player/AtticCamera/fade.visible = true
		%AtticCameraAnimator2.play("enter_attic")
		_on_attic_camera_animator_2_animation_finished("enter_attic")

func _on_attic_camera_animator_2_animation_finished(_anim_name):
	swap_camera()

func swap_camera() -> void:
	%Player.is_player_inattic = true
	if %Player.is_player_inattic is bool and %Player.is_player_inattic == true:
		if get_viewport().get_camera_3d() == camMain:
			camAttic.make_current()
			%Player/AtticCamera/AtticButtonController.visible = true
