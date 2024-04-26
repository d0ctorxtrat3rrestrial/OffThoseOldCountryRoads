extends Node3D

var rotation_target = 0.0
var rotation_speed = 20.0  # Reduced the speed to a third for slower rotation
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

		# Check if mouse enters the left or right side of the screen
		if (in_left_eighth and not prev_in_left_eighth) or (in_right_eighth and not prev_in_right_eighth):
			mouse_entered_area = true

		if in_left_eighth and not rotation_in_progress and mouse_entered_area:
			rotate_camera_smoothly(90.0)
			rotation_in_progress = true
		elif in_right_eighth and not rotation_in_progress and mouse_entered_area:
			rotate_camera_smoothly(-90.0)
			rotation_in_progress = true

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var mouse_pos_x_normalized = (mouse_pos.x / get_viewport().get_visible_rect().size.x)
	delta_time = delta

	if rotation_in_progress:
		var current_rotation = rotation_degrees.y
		rotation_degrees.y = lerp(current_rotation, rotation_target, rotation_speed * delta)

		# Check if the rotation is complete
		if abs(rotation_degrees.y - rotation_target) < 1.0:
			rotation_in_progress = false
			mouse_entered_area = false

func rotate_camera_smoothly(angle):
	rotation_target += angle

func lerp(a, b, t):
	return a + (b - a) * t

func _on_is_hiding():
	# Adjust camera movement behavior when player is hiding
	# For example, stop camera rotation
	rotation_in_progress = false
	
	# Process mouse movement when hiding
	var __mouse_position = get_viewport().get_mouse_position()
	var pan_x_distance_from_border = 50  # Adjust this value as needed

	# Check if the mouse is close to the left or the right side of the screen, then rotate the view
	if in_left_eighth:
		turn_left(40 * delta_time)
	elif in_right_eighth:
		turn_right(40 * delta_time)
	
	# Then we make sure the camera doesn't go too far to the right/left
	rotation_degrees.y = clamp(rotation_degrees.y, -20, 20)

func turn_left(speed):
	rotate_y(deg_to_rad(speed))

func turn_right(speed):
	rotate_y(deg_to_rad(-speed))


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	pass # Replace with function body.


func _on_area_3d_mouse_exited():
	pass # Replace with function body.
