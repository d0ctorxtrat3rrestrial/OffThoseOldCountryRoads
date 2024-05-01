extends Camera3D

var in_left_eighth = false
var in_right_eighth = false
var mouse_entered_area = false


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

func _process(delta):
	#check if the mouse is close to the left or the right side of the screen, then rotate the view
	if in_left_eighth and mouse_entered_area:
		turn_left(60 * delta)
	elif in_right_eighth and mouse_entered_area:
		turn_right(60 * delta)
	#then we make sure the camera doesn't go too far to the right/left
	rotation_degrees.y = clamp(rotation_degrees.y, -10, 10)

func turn_left(speed):
	rotate_y(deg_to_rad(speed))

func turn_right(speed):
	rotate_y(deg_to_rad(-speed))

