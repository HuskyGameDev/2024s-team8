extends Node2D
var HasLeft = true

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

const lines: Array[String] = [
	"I should press 'G' to look over my notes...",
	""
]

# Called when the node enters the scene tree for the first time.
func _ready():
	PositionManager.Act = 0
	if !PositionManager.HasOpenedTutorial && PositionManager.StartFromBeginning:
		player._swap_attention()
		await get_tree().create_timer(1).timeout
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false, true)
		await DialogManager.dialog_finished
		player._swap_attention()
	pass # Replace with function body.


func _on_to_hall_body_entered(body):
	if HasLeft && body.name == "Player":
		body.hasAttention = false
		body.set("active", false)
		const AIRLOCK = preload("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
		StageManager.changeScene(AIRLOCK, 155, 110)
		StageManager.changeCamera(304)
		StageManager.scene_change = true



func _on_to_hall_body_exited(_body):
	HasLeft = true
