extends Area3D

@export var player : Node3D
var camera_node: Camera3D
var transition_speed = 2.0
#@onready var animations : AnimationPlayer = $"../CameraAnimator"

@onready var camMain = %Player.camMain
@onready var camHide = %Player.camHide

func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		%Player.is_player_hiding = true
		if %Player.is_player_hiding is bool and %Player.is_player_hiding == true:
			%CameraAnimator.play("bed_hide")
			_on_camera_animator_animation_finished("bed_hide")

func _on_camera_animator_animation_finished(_anim_name):
	%Player/HideCamera/ButtonController.visible = true
	swap_camera()

func swap_camera() -> void:
	if get_viewport().get_camera_3d() == camMain:
		camHide.make_current()
