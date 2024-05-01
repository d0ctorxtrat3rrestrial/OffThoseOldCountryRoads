extends Button

@export var is_player_hiding = false

@onready var camMain = %Player.camMain
@onready var camHide = %Player.camHide

## Called when the node enters the scene tree for the first time.

func _pressed():
	print("im pressed!")
	%Player/HideCamera/ButtonController.visible = !%Player/HideCamera/ButtonController.visible
	%CameraAnimator2.play("bed_leave")
	_on_camera_animator_2_animation_finished("bed_leave")

func _on_camera_animator_2_animation_finished(_anim_name):
	%Player.is_player_hiding = false
	if %Player.is_player_hiding is bool and %Player.is_player_hiding == false:
		swap_camera()

func swap_camera():
	if get_viewport().get_camera_3d() == %Player.camHide:
			%Player.camMain.make_current()

