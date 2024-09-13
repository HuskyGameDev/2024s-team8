extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")


#Dialogue that the Dialogue manager pulls from
const lines: Array[String] = [
	"A broom lies in the corner. Nothing special."
]

# Called when the node enters the scene tree for the first time.
#Makes the item interactable
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	

#Function for interaction with the object plays Dialogue when interacted with
func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound)
	await DialogManager.dialog_finished
	player._swap_attention()
