extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"A pair of pruning shears.",
	"You picked up the pruning shears."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if !PositionManager.HasShears:
		interaction_area.interact = Callable(self, "_on_interact")
	else: 
		queue_free()


func _on_interact():
	player._swap_attention()
	PositionManager.Inventory.append("Pruning Shears")
	PositionManager.InventoryText.append("A pair of pruning shears")
	PositionManager.InventorySprite.append("res://Assets/Inventory Icons/Pruning Shears.png")
	DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
	await DialogManager.dialog_finished
	PositionManager.HasShears = true
	queue_free()
	player._swap_attention()
