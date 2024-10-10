extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")


const lines: Array[String] = [
	"The pod ejection button."
]

const lines2: Array[String] = [
	"I don't think ejecting my own pod is a good idea..."
]

const lines3: Array[String] = [
	"I need to make sure the pod door is locked before I can eject it. Safety first!"
]

const lines4: Array[String] = [
	"The pod has already been ejected. Let's get out of here!"
]


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	player._swap_attention()
	
	if PositionManager.heliDistracted and !PositionManager.HasDefeatedMonster and PositionManager.OpenedAirlock:
		PositionManager.lastKnownPos.x = player.position.x
		PositionManager.lastKnownPos.y = player.position.y
		get_tree().change_scene_to_file("res://defeat.tscn")
		StageManager.scene_change = true
	elif PositionManager.heliDistracted && !PositionManager.HasDefeatedMonster && !PositionManager.OpenedAirlock:
		
		DialogManager.start_dialog(global_position, lines3, speech_sound2, false)
		await DialogManager.dialog_finished
		
	elif PositionManager.HasDefeatedMonster:
		
		DialogManager.start_dialog(global_position, lines4, speech_sound2, false)
		await DialogManager.dialog_finished
		
	else:
		
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		
		DialogManager.start_dialog(global_position, lines2, speech_sound2, false)
		await DialogManager.dialog_finished
	
	player._swap_attention()
	
	
