extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

const lines: Array[String] = [
	"This vent is located right above the power room, but it's bolted shut.",
	"I might be able to open it with some kind of tool..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	const POWER_ROOM = preload("res://Scenes/Second floor rooms/power_room.tscn")
	if PositionManager.HasCrowbar:
		PositionManager.HasOpenedVent = true
		get_node("Sprite2D").hide()
		StageManager.changeScene(POWER_ROOM, 184, 120)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
	else:
		player._swap_attention()
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		player._swap_attention()
		


