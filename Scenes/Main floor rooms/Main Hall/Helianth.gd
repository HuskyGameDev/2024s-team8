extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_flowey_2-online-audio-converter.mp3")
@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")


const lines: Array[String] = [
	"My name is Helianth, and I am a plant monster!",
	"I am going to kill you and eat you.",
	"Wait...",
	"I shouldn't be here yet...",
	"Welp, see you later! Lalalalalalalalalalala"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	player._swap_attention()
	
	
