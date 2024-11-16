extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")

@onready var freezerDoorClosed = $"%FreezerDoorClosed"
@onready var freezerDoorOpen = $"%FreezerDoorOpen"
@onready var particles1 = $FreezerParticles
@onready var particles2 = $FreezerParticles2
@onready var particles3 = $FreezerParticles3


const lines: Array[String] = [
	"A solid, metallic door leading to the industrial freezer."
]

const lines2: Array[String] = [
	"It is well-stocked with meat and vegetables."
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
	if player.hasAttention:
		player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	
	particles1.emitting = true
	particles2.emitting = true
	particles3.emitting = true
	freezerDoorOpen.visible = true
	freezerDoorClosed.visible = false
	
	DialogManager.start_dialog(global_position, lines2, speech_sound, false)
	await DialogManager.dialog_finished
	
	if PositionManager.Act == 3 && !PositionManager.HasMeat:
		PositionManager.HasMeat = true
		PositionManager.Inventory.append("Meat")
		PositionManager.InventoryText.append("A piece of raw meat")
		PositionManager.InventorySprite.append("res://Assets/Inventory Icons/inventory-meat.png")
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
		DialogManager.start_dialog(global_position, lines3, speech_sound, false)
		await DialogManager.dialog_finished
		
	if PositionManager.HasMeat && PositionManager.HasSpaceSuit && PositionManager.HasHeatLamp:
		DialogManager.start_dialog(global_position, lines5, speech_sound2, false)
		await DialogManager.dialog_finished
		
	particles1.emitting = false
	particles2.emitting = false
	particles3.emitting = false
	freezerDoorOpen.visible = false
	freezerDoorClosed.visible = true
	if !player.hasAttention:
		player._swap_attention()
	
