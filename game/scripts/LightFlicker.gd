extends OmniLight3D

# Parameters for the flickering effect
var min_intensity = 12
var max_intensity = 16
var flicker_speed = 0.1

# Timer for controlling flickering speed
var flicker_timer = 0.0
var flicker_interval = 0.1

func _ready():
	# Start the flickering effect
	flicker_timer = randf()

func _process(delta):
	# Update the flicker timer
	flicker_timer += delta
	
	# Check if it's time to flicker
	if flicker_timer >= flicker_interval:
		flicker_timer -= flicker_interval
		# Generate a random intensity within the range
		var flicker_intensity = randf_range(min_intensity, max_intensity)
		# Apply the flicker intensity to the light
		light_energy = flicker_intensity
