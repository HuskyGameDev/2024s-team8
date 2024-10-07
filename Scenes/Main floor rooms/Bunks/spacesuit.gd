extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")
@onready var bedInteraction = $"%SpaceSuitBedInteraction"

const lines: Array[String] = [
	"A spare spacesuit.",
	"It looks just like me... but orange."
]

const lines2: Array[String] = [
	"This will work perfectly as a decoy person!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.HasSpaceSuit:
		bedInteraction.disabled = false
		set_visible(false)
		queue_free()
	else: 
		interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
	await DialogManager.dialog_finished
	
	if PositionManager.Act == 3:
		PositionManager.HasSpaceSuit = true
		PositionManager.Inventory.append("SpaceSuit")
		PositionManager.InventoryText.append("A spare spacesuit")
		PositionManager.InventorySprite.append("res://Assets/Inventory Icons/inventory-suit.png")
		DialogManager.start_dialog(global_position, lines2, speech_sound2, false, false)
		await DialogManager.dialog_finished
		bedInteraction.disabled = false
		set_visible(false)
		queue_free()
	
	player._swap_attention()
	
