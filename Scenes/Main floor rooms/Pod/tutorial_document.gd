extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")



var lines: Array[String] = [
	"'Press '" + InputMap.action_get_events("OBJECTIVE")[0].as_text() + "' to look over your objectives.'"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.Documents.find("Tutorial Document") == 1:
		queue_free()
	else: 
		interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	if PositionManager.Documents.find("Tutorial Document") == -1:
		PositionManager.Documents.append("Tutorial Document")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines))
		PositionManager.play_notification("Document")
		queue_free()
	player._swap_attention()
	
	
