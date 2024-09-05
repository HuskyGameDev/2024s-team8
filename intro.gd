extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animPlayer = get_tree().get_first_node_in_group("AnimationPlayer")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

const lines: Array[String] = [
	"I can't wait to reach the ship!",
	"Surely nothing bad has happened since we last made contact.",
	"Although, it is a bit weird that all of the lights are off..."
]

func _ready():
	animPlayer.speed_scale = PositionManager.textSpd
	PositionManager.StartFromBeginning = true
	InteractionManager.can_interact = false
	for n in range(0,5):
		PositionManager.comboCode[n] = randi_range(0,9)
	for n in range(0,3):
		PositionManager.valveCode[n] = randi_range(1,23)
	PositionManager.PipeVersion = randi_range(0,2)
		
	DialogManager.start_dialog(global_position, lines, speech_sound, false, true)
	await DialogManager.dialog_finished
	
	InteractionManager.can_interact = true
	
	

func _process(_delta):
	if Input.is_action_just_pressed("MENU"):
		_on_animation_player_animation_finished("")
	
func _on_animation_player_animation_finished(_anim_name):
	var POD = load("res://Scenes/Main floor rooms/Pod/pod.tscn")
	
	if DialogManager.is_dialog_active:
		await DialogManager.dialog_finished
	# Plays act 1 music once intro animation finishes
	GlobalAudioManager.play_act1_music()
	
	StageManager.changeScene(POD, 90, 126)
	StageManager.changeCamera(304)
