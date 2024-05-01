extends Node3D

var rotation_target = 0.0
var rotation_speed = 20.0
var in_left_eighth = false
var in_right_eighth = false
var rotation_in_progress = false
var mouse_entered_area = false
var last_process_time = 0.0
var delta_time = 0.0

@onready var camMain = $Camera3D
@onready var camHide = $HideCamera
@onready var camAttic = $AtticCamera

# New variable to track if the camera is currently hiding
var is_player_hiding = Global.is_player_hiding
var is_player_inattic = Global.is_player_inattic

func _ready():
	camMain.make_current()
#
#func defineState(_is_hiding):
	#if is_player_hiding is bool and is_player_hiding == true:
		#%CameraAnimator.play("bed_hide")
		#_on_camera_animator_animation_finished("bed_hide")
#
#func _on_camera_animator_animation_finished(_anim_name):
	#swap_camera()
#
#func swap_camera() -> void:
	#if get_viewport().get_camera_3d() == camMain:
		#camHide.current = true
		#if camHide:
			#print("Camera is hiding.")


func _on_attic_camera_animator_2_animation_finished(_anim_name):
	pass # Replace with function body.
