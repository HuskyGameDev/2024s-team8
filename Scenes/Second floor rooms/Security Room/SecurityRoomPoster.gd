extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var notificationScene = preload("res://Scripts/Notifications/Notification.tscn")


const lines: Array[String] = [
	"'In case of emergency, press the button to unlock stairwell doors.'"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	if PositionManager.Documents.find("Security Note") == -1:
		PositionManager.Documents.append("Security Note")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines))
		var notification = notificationScene.instantiate()
		%CanvasLayer.add_child(notification)
	player._swap_attention()
	
	
