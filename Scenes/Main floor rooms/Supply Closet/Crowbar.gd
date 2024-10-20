extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"You picked up the wrench."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	player._swap_attention()
	PositionManager.Inventory.append("Wrench")
	PositionManager.InventoryText.append("An ordinary wrench")
	PositionManager.InventorySprite.append("res://Assets/wrench-gray.png")
	DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
	await DialogManager.dialog_finished
	player._swap_attention()
	queue_free()
	PositionManager.HasCrowbar = true
	pass
