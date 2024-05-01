extends Control


# Called when the node enters the scene tree for the first time.

@onready var transition_anim = $Fade/AnimationPlayer

func _on_continue_button_down():
	pass # Replace with function body.


func _on_new_game_button_down():
	start_night(1)

func start_night(what_night):
	print("pressed!")
	transition_anim.play("Fade")
	await transition_anim.animation_finished
	Global.night = what_night
	get_tree().change_scene_to_file("res://game/levels/demo.tscn")

func _on_quit_button_down():
	transition_anim.play("Fade")
	await transition_anim.animation_finished
	get_tree().quit()
