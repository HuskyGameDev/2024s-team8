extends Node2D
var HasLeft = true

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

# REMINDER: Could replace G with + InputMap.action_get_events("OBJECTIVE")[0].as_text() +, after finding out how to remove "(physical)"
var lines: Array[String] = [
	"I should press '" + InputMap.action_get_events("OBJECTIVE")[0].as_text() + "' to look over my notes...", 
	""
]

# Called when the node enters the scene tree for the first time.
#Tells player to press G on startup
#checks if act is between 1 and 0? if so sets it to 0
func _ready():
	
	if PositionManager.Act < 1:
		PositionManager.Act = 0
	if !PositionManager.HasOpenedTutorial && PositionManager.StartFromBeginning:
		player._swap_attention()
		await get_tree().create_timer(1).timeout
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false, true)
		await DialogManager.dialog_finished
		player._swap_attention()
	pass # Replace with function body.

#sets the act to 0 if the player walks in the room if they're in act is 1
func _process(_delta):
	if PositionManager.Act == 1:
		PositionManager.Act = 0

#Switches to airlock scene
func _on_to_hall_body_entered(body):
	if Input.is_action_pressed("DOWN") && HasLeft && body.name == "Player":
		$Player.hasAttention = !StageManager.scene_change
		$Player/AnimationTree.set("active", !StageManager.scene_change)
		var AIRLOCK = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
		StageManager.changeScene(AIRLOCK, 155, 110, true)
		StageManager.changeCamera(304)




func _on_to_hall_body_exited(_body):
	HasLeft = true
