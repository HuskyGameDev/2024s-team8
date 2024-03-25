extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

const lines: Array[String] = [
	"I can't wait to reach the ship!",
	"Surely nothing bad has happened since we last made contact.",
	"Although, it is a bit weird that all of the lights are off..."
]

func _ready():
	PositionManager.StartFromBeginning = true
	InteractionManager.can_interact = false
	for n in range(0,5):
		PositionManager.comboCode[n] = randi_range(0,9)
	DialogManager.start_dialog(global_position, lines, speech_sound, false, true)
	await DialogManager.dialog_finished
	InteractionManager.can_interact = true
	
	

func _process(delta):
	if Input.is_action_just_pressed("MENU"):
		const POD = preload("res://Scenes/Main floor rooms/pod.tscn")
		
		# Plays act 1 music if intro is skipped
		GlobalAudioManager.play_act1_music()
		
		StageManager.changeScene(POD, 90, 126)
		StageManager.changeCamera(304)
	
func _on_animation_player_animation_finished(_anim_name):
	const POD = preload("res://Scenes/Main floor rooms/pod.tscn")
	
	# Plays act 1 music once intro animation finishes
	GlobalAudioManager.play_act1_music()
	
	StageManager.changeScene(POD, 90, 126)
	StageManager.changeCamera(304)
