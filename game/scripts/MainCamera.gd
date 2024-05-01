extends Camera3D

var rotation_target = 0.0
var rotation_speed = 20.0
var in_left_eighth = false
var in_right_eighth = false
var rotation_in_progress = false
var mouse_entered_area = false
var last_process_time = 0.0
var delta_time = 0.0

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_x = event.global_position.x
		var prev_in_left_eighth = in_left_eighth
		var prev_in_right_eighth = in_right_eighth
		in_left_eighth = mouse_x < get_viewport().size.x / 8
		in_right_eighth = mouse_x > (get_viewport().size.x * 7) / 8

		if (in_left_eighth and not prev_in_left_eighth) or (in_right_eighth and not prev_in_right_eighth):
			mouse_entered_area = true

			if in_left_eighth and not rotation_in_progress and mouse_entered_area:
				rotate_camera_smoothly(90.0)
				rotation_in_progress = true
			elif in_right_eighth and not rotation_in_progress and mouse_entered_area:
				rotate_camera_smoothly(-90.0)
				rotation_in_progress = true

func _process(delta):
	delta_time = delta
	if rotation_in_progress:
		var current_rotation = rotation_degrees.y
		rotation_degrees.y = lerp(current_rotation, rotation_target, rotation_speed * delta)

		if abs(rotation_degrees.y - rotation_target) < 1.0:
			rotation_in_progress = false
			mouse_entered_area = false


func rotate_camera_smoothly(angle):
	rotation_target += angle

func lerp(a, b, t):
	return a + (b - a) * t
