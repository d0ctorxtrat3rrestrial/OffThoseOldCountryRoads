extends Area3D


var click = false
var leftDialTurn = false
var rightDialTurn = false

signal is_clicked
signal is_turning

func _on_Button_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.click and event.button_index == MOUSE_BUTTON_LEFT:
		click = !click
		if is_clicked:
			print('click')
		else:
			print('No click')
