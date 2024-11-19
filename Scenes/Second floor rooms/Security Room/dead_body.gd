extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"A crew member lies on the ground, cold and lifeless.",
	"The body looks malnourished... how long were they in here?",
	"You notice a security keycard with the name 'Dave A.' imprinted on it.",
	"You picked up the keycard."
]

const lines2: Array[String] = [
	"You don't want to be here anymore..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	player._swap_attention()
	if !PositionManager.HasKeycard:
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
		await DialogManager.dialog_finished
		PositionManager.HasKeycard = true
		PositionManager.Inventory.append("Keycard")
		PositionManager.InventoryText.append("A security keycard for 'Dave A.'")
		PositionManager.InventorySprite.append("res://Assets/Inventory Icons/keycard.png")
	else:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false, false)
		await DialogManager.dialog_finished
	player._swap_attention()
