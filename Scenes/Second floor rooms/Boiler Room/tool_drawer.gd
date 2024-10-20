extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")


const lines: Array[String] = [
	"A large tool cabinet, filled to the brim with maintenance equipment."
]

const lines2: Array[String] = [
	"You notice a heating lamp in one of the compartments."
]

const lines3: Array[String] = [
	"You picked up the heating lamp."
]

const lines4: Array[String] = [
	"I don't think there is anything else here that will help me."
]


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	
	if PositionManager.Act == 3 && !PositionManager.HasHeatLamp:
		PositionManager.HasHeatLamp = true
		PositionManager.Inventory.append("HeatLamp")
		PositionManager.InventoryText.append("A heating device")
		PositionManager.InventorySprite.append("res://Assets/Inventory Icons/inventory-lamp.png")
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
		DialogManager.start_dialog(global_position, lines3, speech_sound, false)
		await DialogManager.dialog_finished
	elif !PositionManager.HasHeatLamp:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
	else:
		DialogManager.start_dialog(global_position, lines4, speech_sound2, false)
		await DialogManager.dialog_finished
	
	player._swap_attention()
	
