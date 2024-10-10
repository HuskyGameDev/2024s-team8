extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")

@onready var freezerDoorClosed = $"%FreezerDoorClosed"
@onready var freezerDoorOpen = $"%FreezerDoorOpen"


const lines: Array[String] = [
	"A solid, metallic door leading to the mess hall freezer."
]

const lines2: Array[String] = [
	"In it lies a single piece of frozen meat. It hasn't been opened yet..."
]

const lines3: Array[String] = [
	"You picked up the meat."
]

const lines4: Array[String] = [
	"There's nothing in it."
]

const lines5: Array[String] = [
	"Now that I have all of the components for the decoy, I can go to the pod and lure the monster in!"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	


func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	freezerDoorOpen.visible = true
	freezerDoorClosed.visible = false
	
	if PositionManager.Act == 3 && !PositionManager.HasMeat:
		PositionManager.HasMeat = true
		PositionManager.Inventory.append("Meat")
		PositionManager.InventoryText.append("A piece of raw meat")
		PositionManager.InventorySprite.append("res://Assets/Inventory Icons/inventory-meat.png")
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
		DialogManager.start_dialog(global_position, lines3, speech_sound, false)
		await DialogManager.dialog_finished
	elif !PositionManager.HasMeat:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
	else:
		DialogManager.start_dialog(global_position, lines4, speech_sound, false)
		await DialogManager.dialog_finished
	
	if PositionManager.HasMeat && PositionManager.HasSpaceSuit && PositionManager.HasHeatLamp:
		DialogManager.start_dialog(global_position, lines5, speech_sound2, false)
		await DialogManager.dialog_finished
		
	freezerDoorOpen.visible = false
	freezerDoorClosed.visible = true
	player._swap_attention()
	
