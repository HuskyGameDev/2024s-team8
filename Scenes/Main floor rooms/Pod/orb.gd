extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")


const lines: Array[String] = [
	"You picked up the cool orb lying on the ground."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.HasOrb:
		set_visible(false)
		queue_free()
	else:
		interaction_area.interact = Callable(self, "_on_interact")
	


func _on_interact():
	player._swap_attention()
	PositionManager.HasOrb = true
	PositionManager.Inventory.append("Orb")
	PositionManager.InventoryText.append("A cool orb you found on the ground")
	PositionManager.InventorySprite.append("res://Assets/dial.png")
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	set_visible(false)
	queue_free()
	player._swap_attention()
	pass
	
	
