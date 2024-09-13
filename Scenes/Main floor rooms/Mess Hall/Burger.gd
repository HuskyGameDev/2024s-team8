extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

const lines: Array[String] = [
	"Wow this burger looks amazing!",
	"Don't mind if I do."
]

const lines2: Array[String] = [
	"EWWWW THERE WAS A COCKROACH UNDERNEATH THE BURGER!!!!!!!",
	"I'M GOING TO KILL YOU!!!!!"
]

# Called when the node enters the scene tree for the first time.
#Makes the item interactable
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


#Function for interaction with the object plays Dialogue when interacted with
func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound)
	await DialogManager.dialog_finished
	PositionManager.HasEatenBurger = true
	get_child(1).queue_free()
	get_child(2).queue_free()
	await get_tree().create_timer(1).timeout
	DialogManager.start_dialog(global_position, lines2, speech_sound)
	await DialogManager.dialog_finished
	queue_free()
	player._swap_attention()
	pass
