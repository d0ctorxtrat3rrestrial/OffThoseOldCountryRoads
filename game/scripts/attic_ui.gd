extends Button
@onready var camMain = %Player.camMain
@onready var camAttic = %Player.camAttic

## Called when the node enters the scene tree for the first time.

func _pressed():
	%Player/AtticCamera/AtticButtonController.visible = false
	%AtticCameraAnimator.play("leave_attic")
	_on_attic_camera_animator_animation_finished("leave_attic")

func _on_attic_camera_animator_animation_finished(_anim_name):
	Global.is_player_inattic = false
	if Global.is_player_inattic is bool and Global.is_player_inattic == false:
		swap_camera()

func swap_camera():
	if get_viewport().get_camera_3d() == %Player.camAttic:
			%Player.camMain.make_current()
