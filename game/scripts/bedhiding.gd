extends Area3D

@export var player : Node3D
var camera_node: Camera3D
var original_camera_position: Vector3

signal is_hiding
signal not_hiding

# Track if the player is currently hiding
var is_player_hiding: bool = false

func _ready():
	# Traverse the scene hierarchy to find the Camera3D node
	camera_node = get_node("../Player/Camera3D")
	if camera_node == null:
		print("Camera3D node not found!")
	else:
		print("Camera3D node found:", camera_node)
	original_camera_position = camera_node.global_transform.origin

func _on_button_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.player_hiding:
		# Example desired camera position when hiding
		var desired_camera_position = Vector3(-2, 1, 5)
		desired_camera_position = rotate_desired_position(desired_camera_position, deg_to_rad(-90))
		player_hiding(desired_camera_position)
		emit_signal("is_hiding", desired_camera_position)

@warning_ignore("shadowed_variable_base_class")
func rotate_desired_position(position: Vector3, angle_rad: float) -> Vector3:
	# Rotate the desired position around the y-axis by the specified angle
	var rotated_position = position.rotated(Vector3(-2, 1, 5), angle_rad)
	return rotated_position

func player_hiding(desired_camera_position: Vector3) -> void:
	# Move the camera to the desired position
	set_camera_position(desired_camera_position)
	# Set player hiding state to true
	is_player_hiding = true

func set_camera_position(desired_camera_position: Vector3) -> void:
	# Set the camera's global position to the desired position
	camera_node.global_transform.origin = desired_camera_position

func reset_camera_position() -> void:
	# Reset the camera position to its original position
	set_camera_position(original_camera_position)
	# Reset player hiding state to false
	is_player_hiding = false
	emit_signal("not_hiding")
	
func _on_Player_stopHiding():
	reset_camera_position()
