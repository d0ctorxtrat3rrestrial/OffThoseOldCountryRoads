extends Node3D

#plays a jumpscare and changes scene when the jumpscare finishes

@onready var mothman = $Mothman
#@onready var animatronic_two = $AnimatronicTwo
@onready var audio = $MothJumpscareSound
@onready var cam = $Camera3D
var jumpscare

func _ready():
	$Mothman.hide()
	#$AnimatronicTwo.hide()

func _on_cryptid_controller_jumpscare(cryptid):
	match cryptid:
		"mothman":
			mothman.show()
			%MothJumpscare.play("jumpscare")
		#"animatronic_two":
			#animatronic_two.show()
			#animatronic_two.get_node("AnimationPlayer").play("jumpscare")
	cam.current = true
	
	audio.play()

func jumpscare_ended():
	get_tree().change_scene_to_file("res://game/menu/game_over.tscn")
