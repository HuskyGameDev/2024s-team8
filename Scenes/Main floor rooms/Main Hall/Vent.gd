extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"This vent is located right above the power room, but it's bolted shut.",
	"I might be able to open it with some kind of tool..."
]

const lines2: Array[String] = [
	"An ordinary vent. It feels kind of warm..."
]

const lines3: Array[String] = [
	"You used the wrench."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	if PositionManager.HasOpenedVent == true:
		get_node("Sprite2D").queue_free()


func _on_interact():
	var POWER_ROOM = load("res://Scenes/Second floor rooms/Power Room/power_room.tscn")
	player._swap_attention()
	if PositionManager.ViewedWallMap:
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
	else:
		DialogManager.start_dialog(global_position, lines2, speech_sound2, false)
		await DialogManager.dialog_finished
	
	if PositionManager.HasCrowbar && get_node("Sprite2D") != null: #runs if not queue_free() and player has crowbar
		DialogManager.start_dialog(global_position, lines3, speech_sound2, false)
		await DialogManager.dialog_finished
		player._swap_attention()
		PositionManager.HasOpenedVent = true
		get_node("Sprite2D").queue_free()
		StageManager.player_facing = Vector2(-1, 0)
		StageManager.changeScene(POWER_ROOM, 184, 120)
		StageManager.changeCamera(304)
		StageManager.on_first_floor = false
		PositionManager.PrevPosition = Vector2(220, 130)
	player._swap_attention()
	
