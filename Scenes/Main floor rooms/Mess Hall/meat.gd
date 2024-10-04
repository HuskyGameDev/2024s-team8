extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")


const lines: Array[String] = [
	"A raw piece of meat."
]

const lines2: Array[String] = [
	"I wonder if the monster will enjoy this meat..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.HasMeat:
		set_visible(false)
		queue_free()
	else:
		interaction_area.interact = Callable(self, "_on_interact")



func _on_interact():
	if PositionManager.Act == 3:
		player._swap_attention()
		PositionManager.HasMeat = true
		PositionManager.Inventory.append("res://Assets/RawMeat.png")
		PositionManager.InventoryText.append("A piece of raw meat")
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
	
	
