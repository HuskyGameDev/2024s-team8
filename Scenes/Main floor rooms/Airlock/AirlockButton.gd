extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var Airlock = get_tree().get_first_node_in_group("Airlock")

@onready var timer = get_tree().get_first_node_in_group("Timer")

const lines: Array[String] = [
	"You press the button...",
	"Nothing happens."
]

const lines2: Array[String] = [
	"You press the button...",
	"Something happens!"
]

# Called when the node enters the scene tree for the first time.
#Allows player to interact with the button then starts a timer
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	timer.wait_time = 5



#Unpushes the button when the timer is out of time
func _on_timer_1_timeout():
	Airlock.Button1 = false
	pass # Replace with function body.


#Pushes the button when the player interacts with it if they have pushed the other button
#and the airlock isnt open yet opens the airlock
func _on_interact():
	player._swap_attention()
	if Airlock.Button2:
		Airlock.Button1 = false
		Airlock.Button2 = false
		PositionManager.OpenedAirlock = !PositionManager.OpenedAirlock
		GlobalAudioManager.door_SFX() # Plays door opening SFX
		DialogManager.start_dialog(global_position, lines2, speech_sound, false)
		await DialogManager.dialog_finished
	else: 
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		Airlock.Button1 = true
		timer.start()
	player._swap_attention()
	pass
	
	
