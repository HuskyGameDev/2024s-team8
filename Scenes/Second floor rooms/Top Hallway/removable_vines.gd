extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

const lines: Array[String] = [
	"A thick layer of vines prevents anyone from accessing the stairs...",
]

const lines2: Array[String] = [
	"You used the pruning shears."
]


# Called when the node enters the scene tree for the first time.
func _ready():
	if !PositionManager.HasRemovedVines:
		interaction_area.interact = Callable(self, "_on_interact")
	else: 
		queue_free()


func _on_interact():
	
	player._swap_attention()
	
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	
	if PositionManager.HasShears:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
		queue_free()
		PositionManager.HasRemovedVines = true
	
	player._swap_attention()
