extends Node

#stuff that we want to be able to access anywhere

var screen_resolution
var night = 1

var is_player_hiding = false
var is_player_inattic = false

func _ready():
	screen_resolution = get_viewport().size

