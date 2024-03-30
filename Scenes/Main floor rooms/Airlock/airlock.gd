extends Node2D


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var timer = get_tree().get_first_node_in_group("Timer")


var Button1 = false
var Button2 = false

var count = 0

const lines: Array[String] = [
	"The door is sealed shut."
]

func _ready():
	PositionManager.Act = 1

func _on_to_hall_body_entered(body):
	count += 1
	if count > 1:
		if body.name == "Player":
			if PositionManager.OpenedAirlock:
				const HALL = preload("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
				$Player.hasAttention = false
				$Player/AnimationTree.set("active", false)
				StageManager.changeScene(HALL, 76, 130)
				StageManager.changeCamera(480)
				StageManager.scene_change = true
			else:
				player._swap_attention()
				DialogManager.start_dialog(global_position, lines, speech_sound)
				await DialogManager.dialog_finished
				player._swap_attention()
				

func _on_to_pod_body_entered(body):
	count += 1
	if count > 1:
		if body.name == "Player":
			const POD = preload("res://Scenes/Main floor rooms/Pod/pod.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(POD, 148, 136)
			StageManager.changeCamera(304)
			StageManager.scene_change = true
