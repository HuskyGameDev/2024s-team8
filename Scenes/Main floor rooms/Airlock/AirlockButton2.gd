extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var Airlock = get_tree().get_first_node_in_group("Airlock")

@onready var timer = get_tree().get_first_node_in_group("Timer")

const lines: Array[String] = [
	"You press the button...",
	"Nothing happens."
]

const lines2: Array[String] = [
	"You press the button...",
	"Something happens!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	timer.wait_time = 5

func _on_timer_timeout():
	Airlock.Button2 = false
	pass # Replace with function body.

func _on_interact():
	player._swap_attention()
	if Airlock.Button1 && !PositionManager.OpenedAirlock:
		PositionManager.OpenedAirlock = true
		GlobalAudioManager.door_SFX() # Plays door opening SFX
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
	else: 
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		Airlock.Button2 = true
		timer.start()
	player._swap_attention()
	pass
	
	


