extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var notificationScene = preload("res://Scripts/Notifications/Notification.tscn")


#const lines: Array[String] = [
	#"'Attention Staff!'",
	#"'Due to the recent number of button-related accidents, we have decided to improve our airlock functionality.'",
	#"'To open the opposite door, please press both of the buttons within the 5-second time interval.'"
#]

# Alternative explanation
const lines: Array[String] = [
	"'To ensure the safety of the crew:'",
	"'One door must remained lock at a time.'",
	"'To unlock the opposite door, please press both of the buttons within the 5-second time interval.'"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	if PositionManager.Documents.find("Airlock Document") == -1:
		PositionManager.Documents.append("Airlock Document")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines))
		var notification = notificationScene.instantiate()
		%CanvasLayer.add_child(notification)
	player._swap_attention()
	
	
