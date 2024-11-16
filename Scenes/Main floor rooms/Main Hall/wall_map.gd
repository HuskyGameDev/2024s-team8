extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

@onready var FullMapScene = preload("res://Minimap/Full_Map.tscn")

const lines: Array[String] = [
	"A map of the ship hangs on the wall.",
	"The edges are tattered, and the color has faded."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	var fullMap = FullMapScene.instantiate()
	get_parent().get_node("CanvasLayer2").add_child(fullMap)
	#$"%Paper Sound".play()
	

func _on_canvas_layer_child_exiting_tree(node: Node) -> void:
	if node.name == "FullMap":
		player._swap_attention()
		
