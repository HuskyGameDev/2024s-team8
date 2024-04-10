extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")


const lines: Array[String] = [
	"A handwritten note sits on the ground.",
	"'Note to self: Tell the boiler room mechanic to return the security keycode document.'",
	"'I know his wife works in security, but he shouldn't need to keep it on him all the time...'"
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
	pass
	
	


