extends Node2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")
@onready var player = get_tree().get_first_node_in_group("Player")


const lines: Array[String] = [
	"Lying in front of the rat cages is a lab report.",
	"'Report 5901' written by someone named 'Dave A.'",
	"That name sounds familiar..."
]

const lines2: Array[String] = [
	"Report 5901, Dave A:",
	"I'm so close to killing that idiot of a man (if Lucy doesn't do it first).",
	"I just cannot understand how the hell Doug even got a job!",
	"He's physically incapable of following any form of rule or regulation, and this time",
	"one of the lab rats--Lab Specimen 5901--got caught in the crossfire.",
	"He managed to leave one of the cages unlocked. Of course, I'm the one who discovered it this morning.",
	"The cage door was open, and Ratthew was nowhere to be found. Lucys going to be pissed...",
	"I warned her about getting attached, but Doug's incompetence is past that.",
	"Of course he insists the cage was locked when he left last night, but clearly it wasn't!"
]

func _ready() -> void:
	if PositionManager.Documents.find("Report 5901") == -1:
		interaction_area.interact = Callable(self, "_on_interact")
	else: 
		queue_free()
	

func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	
	if PositionManager.Documents.find("Report 5901") == -1:
		PositionManager.Documents.append("Report 5901")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines2))
		PositionManager.DocumentsPaper.append(false)
		PositionManager.play_notification("Document")
		queue_free()
		
	player._swap_attention()
	
