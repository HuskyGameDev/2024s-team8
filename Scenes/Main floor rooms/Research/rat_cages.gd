extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"The labels of these small cages have specimen IDs and planets of origin printed on them.",
	"At the bottoms of these labels, someone wrote names in pink pen, all of which are rat-related puns.",
	"A few of the names are written in blue pen, with neat, square handwriting.",
	"The cages are empty..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
	await DialogManager.dialog_finished
	player._swap_attention()
