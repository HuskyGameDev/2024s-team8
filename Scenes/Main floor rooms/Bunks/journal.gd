extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")


const lines: Array[String] = [
	"Someone left a journal here, it has the name 'Doug E.' listed inside",
	"'Lucy and Dave were flirting across the serving trays again during dinner today.'",
	"'They need to get it together and actually GET TOGETHER before someone drowns in the tension.'",
	"'Or at least before one of them gets stabbed with a fork for keeping me from the dessert tray...'"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.Documents.find("Doug's Journal Entry") == -1:
		interaction_area.interact = Callable(self, "_on_interact")
	else: 
		queue_free()


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	if PositionManager.Documents.find("Doug's Journal Entry") == -1:
		PositionManager.Documents.append("Doug's Journal Entry")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines, 1))
		PositionManager.DocumentsPaper.append(true)
		PositionManager.play_notification("Document")
		queue_free()
	player._swap_attention()

	
	
