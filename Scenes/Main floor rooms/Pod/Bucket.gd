extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")


const lines: Array[String] = [
	"This is ridiculous...",
	"They really expected me to use a bucket for a bathroom?",
	"What a great company I work for..."
]

# Called when the node enters the scene tree for the first time.
#Makes the item interactable
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


#Function for interaction with the object plays Dialogue when interacted with
func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	player._swap_attention()
	pass
	
	
