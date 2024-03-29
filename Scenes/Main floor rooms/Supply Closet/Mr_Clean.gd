extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")
@onready var MrCleanScene = preload("res://Scenes/Main floor rooms/Supply Closet/MrClean.tscn")

var minigame = null

const lines: Array[String] = [
	"A bottle of 'Mr. Clean M.Net Multi-Surfaces Disinfectant, Summer Citrus Edition. Kills 99.9% of bacteria."
]

const lines2: Array[String] = [
	"Yeah, I think I'll pass..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound)
	await DialogManager.dialog_finished
	
	if minigame == null:
		await get_tree().create_timer(0.001).timeout
		minigame = MrCleanScene.instantiate()
		Canvas.add_child(minigame)
	
	await Canvas.get_child(0).tree_exited
	DialogManager.start_dialog(global_position, lines2, speech_sound2)
	await DialogManager.dialog_finished
	player._swap_attention()
	
