extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var animPlayer = get_tree().get_first_node_in_group("AnimationPlayer")

const engineHumming = preload("res://Assets/Audio/Music/BED_shipengine_LP.wav")

const lines: Array[String] = [
	"You are still being hunted by the creature.",
	"Any attempt to pilot the ship is ill-advised..."
]

const lines2: Array[String] = [
	"You take control of the ship, and begin piloting back home...",
	"Something doesn't feel right..."
]


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	StageManager.changeCamera(488)
	
	if player.hasAttention:
		player.hasAttention = false
	DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
	await DialogManager.dialog_finished
	if !player.hasAttention:
		player.hasAttention = true



func _on_interact():
	if PositionManager.HasDefeatedMonster:
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/outro.tscn")
	else:
		player.hasAttention = false
		DialogManager.start_dialog(global_position, lines2, speech_sound, false, false)
		await DialogManager.dialog_finished
		await get_tree().create_timer(0.75).timeout
		animPlayer.play("Scary")


func _on_door_body_entered(body):
	if (Input.is_action_pressed("LEFT") or Input.is_action_pressed("UP")) and body.name == "Player":
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(-1,0)
			StageManager.changeScene(HALLWAY_MAIN, 455, 130)
			StageManager.changeCamera(488)
