extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")


const lines: Array[String] = [
	"You press the button...",
	"Something happens!"
]

const lines2: Array[String] = [
	"You press the button...",
	"Nothing happens!"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	player._swap_attention()
	if PositionManager.SecurityEnabled:
		PositionManager.SecurityEnabled = false
		PositionManager.Act = 3
		GlobalAudioManager.door_SFX() # Plays door opening SFX
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
	else:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
	player._swap_attention()
	
	
	
