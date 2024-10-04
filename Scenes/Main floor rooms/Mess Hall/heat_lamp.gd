extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")


const lines: Array[String] = [
	"An ordinary heating lamp."
]

const lines2: Array[String] = [
	"This will allow me to heat something up!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.HasHeatLamp:
		set_visible(false)
		queue_free()
	else:
		interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	if PositionManager.Act == 3:
		player._swap_attention()
		PositionManager.HasHeatLamp = true
		PositionManager.Inventory.append("res://Assets/HeatLamp.png")
		PositionManager.InventoryText.append("A heating lamp")
		DialogManager.start_dialog(global_position, lines2, speech_sound2, false, false)
		await DialogManager.dialog_finished
		player._swap_attention()
		set_visible(false)
		queue_free()
	else: 
		player._swap_attention()
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
		await DialogManager.dialog_finished
		player._swap_attention()
	
	
