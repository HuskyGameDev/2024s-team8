extends Node2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var player = $"../Player"

const lines: Array[String] = [
	"Its a poem the mechanic wrote to his wife, I wonder why he left it here?"
]

const lines1: Array[String] = [
	"Maybe this relates somehow to the code to the Security room, I'm going to put this in my Documents."
]

const lines2: Array[String] = [
	"To me, you are the sun
	You brighten up my day
	The navigator tells me we use the stars to guide our journey
	“We follow the north star” he says,
	I don’t fully understand 
	In this dim moist basement, I don’t see any stars
	All there is here is metal and must.       	           	
	I’ve heard the sun rises in the east
	so maybe you can guide me
	back to you
	These incandescent bulbs have brought me down
	but your light will lift me up
	For now, I keep your picture in my left pocket
	and await our reunion."
]

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	

func _on_interact():
	player._swap_attention()
	DialogManager.start_dialog(global_position, lines, speech_sound, false)
	await DialogManager.dialog_finished
	DialogManager.start_dialog(global_position, lines1, speech_sound, false)
	await DialogManager.dialog_finished
	
	if PositionManager.Documents.find("Poem") == -1:
		PositionManager.Documents.append("Poem")
		PositionManager.DocumentsText.append(PositionManager.array_to_string(lines2))
	
	player._swap_attention()
	PositionManager.HasPoem = true
	$".".queue_free()
