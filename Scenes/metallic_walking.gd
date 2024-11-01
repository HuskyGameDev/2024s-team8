extends AudioStreamPlayer2D

const metallicFloor1 = preload("res://Assets/Audio/Sound Effects/PC_footstepMetal1.mp3")
const metallicFloor2 = preload("res://Assets/Audio/Sound Effects/PC_footstepMetal3.mp3")

var current = metallicFloor1

# Called when the node enters the scene tree for the first time.
func _play_footstep_audio():
	stream = current
	pitch_scale = randf_range(0.95, 1.05)
	play()
	swap_stream()

func swap_stream():
	if current == metallicFloor1:
		current = metallicFloor2
	elif current == metallicFloor2:
		current = metallicFloor1
