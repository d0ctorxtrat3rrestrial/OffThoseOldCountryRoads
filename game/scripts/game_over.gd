extends Control

#ded

func _ready():
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://game/menu/main_menu.tscn")
