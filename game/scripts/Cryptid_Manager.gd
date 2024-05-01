extends Node3D

#paths to nodes
@onready var game = get_tree().get_root().get_node("Game")
@onready var mothman = $Mothman
@onready var audio = $MothMove

#var offset = Vector3(-0, 0, -10)
var position1 = Vector3(-30.695, 1.381, -10.326)
var position2 = Vector3(-35.595, 0.386, -1.506)
var position3 = Vector3(-39.623 , 1.047, -6.423)

var mothman_INACTIVE_POSITION = Vector3(29.817, -14.293, -14.063)

var MOTHMAN_ACTIVE_POSITIONS = [position1, position2, position3]

const MAX_AI_LEVEL = 20
const CRYPTIDS_EXTRA_WAIT_TIME_MAX = 10
const CRYPTIDS_AI_NIGHT_ONE = [3, 2]
const CRYPTIDS_AI_NIGHT_TWO = [5, 15]

var cryptids_ai = []

signal cryptid_movement
signal jumpscare(cryptid)

func _ready():
	randomize()
	var global_position = $Mothman.global_transform.origin
	print("Global Position: ", global_position)
	set_animatronics_to_starting_position()
	match Global.night:
		1:
			cryptids_ai = CRYPTIDS_AI_NIGHT_ONE
			await get_tree().create_timer(20).timeout
			activate_mothman()
			print("moth is active")

func activate_mothman():
	for attack in range(500):
		for position in MOTHMAN_ACTIVE_POSITIONS:
			emit_signal("cryptid_movement")
			mothman.global_transform.origin = position
			
			await get_tree().create_timer((MAX_AI_LEVEL + 5) - cryptids_ai[0] + randf_range(0, CRYPTIDS_EXTRA_WAIT_TIME_MAX)).timeout
			if position == MOTHMAN_ACTIVE_POSITIONS[2]:
				$Mothman/blockbench_export/AnimationPlayer.play("pose1")
				print("moth moved")
			if position == MOTHMAN_ACTIVE_POSITIONS[1]:
				$Mothman/blockbench_export/AnimationPlayer.play("pose2")
				print("moth moved")
			if position == MOTHMAN_ACTIVE_POSITIONS[0]:
				$Mothman/blockbench_export/AnimationPlayer.play("pose3")
				print("moth moved")
				await get_tree().create_timer(1.0).timeout  # Wait for a short time before moving to the next position
				print("brace for jumpscare")
				if not Global.is_player_hiding:
					emit_signal("jumpscare", "mothman")

func set_animatronics_to_starting_position():
	mothman.global_transform.origin = mothman_INACTIVE_POSITION
