extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")


const lines: Array[String] = [
	"END SECURITY LOCKDOWN?",
	"WARNING: THREAT DETECTED IN SECTION: [GREENHOUSE]. DO YOU WISH TO PROCEED?",
	"PLEASE CONFIRM CREDENTIALS.",
	"SECURITY LOCKDOWN ENDED. SHIP OPERATIONS RETURNING TO NORMAL."
]

const lines2: Array[String] = [
	"The security room maintenance system.",
	"You notice several of the screens are cracked and dirty."
]

const lines3: Array[String] = [
	"END SECURITY LOCKDOWN?",
	"WARNING: THREAT DETECTED IN SECTION: [GREENHOUSE]. DO YOU WISH TO PROCEED?",
	"PLEASE CONFIRM CREDENTIALS.",
	"INCORRECT CREDENTIALS DETECTED. AUTHORIZED SECURITY PERSONNEL REQUIRED."
]


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	player._swap_attention()
	if PositionManager.SecurityEnabled:
		if PositionManager.HasKeycard:
			PositionManager.SecurityEnabled = false
			PositionManager.Act = 3
			DialogManager.start_dialog(global_position, lines, speech_sound, false)
			await DialogManager.dialog_finished
			if PositionManager.Objectives.find("Remove Security Lockdown") != -1:
				PositionManager.remove_objective("Remove Security Lockdown")
			if !PositionManager.hasActivatedHeli:
				if PositionManager.Objectives.find("Investigate Greenhouse") == -1:
					PositionManager.add_objective("Investigate Greenhouse", "Investigate Greenhouse for any threats.")
			GlobalAudioManager.door_SFX() # Plays door opening SFX
		else:
			DialogManager.start_dialog(global_position, lines3, speech_sound, false)
			await DialogManager.dialog_finished
			
	else:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
	player._swap_attention()
	
	
	
