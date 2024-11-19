extends Node2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")
@onready var player = get_tree().get_first_node_in_group("Player")


const lines: Array[String] = [
	"Lying in front of the rat cages is a lab report.",
	"'Report 5901-2' written by someone named 'Dave A.'",
	"That name sounds familiar..."
]

const lines2: Array[String] = [
	"Report 5901-2, Dave A:",
	"I believe I found the missing lab rat.",
	"Specimen H3-L1 seems to have consumed him... I found rat bones in its pot.",
	"I'm not sure how it caught him, as discussed in my previous report H3-L1-3. To reiterate,",
	"'How could a stationary, carnivorous plant survive on warm meat as sustenance?'",
	"There's no way Ratthew decided to just jump into the creatures pot... right?",
	"Clearly there is something wrong with our current hypothesis. Further research necesssary."
]

func _ready() -> void:
	if PositionManager.Documents.find("Report 5901-2") == -1:
		interaction_area.interact = Callable(self, "_on_interact")
	else: 
		queue_free()
	

func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	
	if PositionManager.Documents.find("Report 5901-2") == -1:
		PositionManager.Documents.append("Report 5901-2")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines2))
		PositionManager.DocumentsPaper.append(false)
		PositionManager.play_notification("Document")
		queue_free()
		
	player._swap_attention()
	
