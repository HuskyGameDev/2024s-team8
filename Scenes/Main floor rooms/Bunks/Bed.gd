extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"A twin-sized bed. Underneath lies a human-sized gap.",
	"It looks like this bed hasn't been used for a while..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
	await DialogManager.dialog_finished
	player._swap_attention()
	pass
