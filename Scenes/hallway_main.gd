extends Node2D

@onready var Player = get_node("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")
var count = 0
const lines: Array[String] = [
	"This door is locked! I must find another way to reach the second floor."
]

const lines2: Array[String] = [
	"This door is locked!"
]

var HasLeft = true

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)
	InteractionManager.player = Player
	if PositionManager.PrevPosition != Vector2.ZERO:
		Player.global_position = PositionManager.PrevPosition
		HasLeft = false
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_mess_hall_body_entered(body):
	const MESS = preload("res://Scenes/Main floor rooms/Mess Hall/mess_hall.tscn")
	if body.name == "Player" && HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		PositionManager.PrevPosition = body.global_position
		StageManager.changeScene(MESS, 232, 120)
		StageManager.changeCamera(304)
		StageManager.scene_change = true

func _on_mess_hall_body_exited(_body):
	HasLeft = true
	pass # Replace with function body.

func _on_research_room_body_entered(body):
	const RESEARCH = preload("res://Scenes/Main floor rooms/research1.tscn")
	if body.name == "Player" && HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		PositionManager.PrevPosition = body.global_position
		StageManager.changeScene(RESEARCH, 80, 128)
		StageManager.changeCamera(304)
		StageManager.scene_change = true

func _on_research_room_body_exited(_body):
	HasLeft = true
	pass # Replace with function body.

func _on_pod_body_entered(body):
	const AIRLOCK = preload("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
	if body.name == "Player" && HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		PositionManager.PrevPosition = body.global_position
		StageManager.changeScene(AIRLOCK, 158, 126) 
		StageManager.changeCamera(304)
		StageManager.scene_change = true

func _on_pod_body_exited(_body):
	HasLeft = true


func _on_bunks_body_entered(body):
	const BUNKS = preload("res://Scenes/Main floor rooms/bunks.tscn")
	if body.name == "Player" && HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		PositionManager.PrevPosition = body.global_position
		StageManager.changeScene(BUNKS, 240, 144)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
		
func _on_bunks_body_exited(_body):
	HasLeft = true
	pass # Replace with function body.

func _on_supply_closet_body_entered(body):
	const SUPPLY = preload("res://Scenes/Main floor rooms/Supply Closet/supply_closet.tscn")
	if body.name == "Player" && HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		PositionManager.PrevPosition = body.global_position
		StageManager.changeScene(SUPPLY, 124, 116)
		StageManager.changeCamera(304)
		StageManager.scene_change = true

func _on_supply_closet_body_exited(_body):
	HasLeft = true
	pass # Replace with function body.

func _on_stairs_body_entered(body):
	const STAIRS = preload("res://Scenes/Main floor rooms/stairs.tscn")
	if body.name == "Player":
		if PositionManager.Act != 1:
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(STAIRS, 59, 89)
			StageManager.changeCamera(304)
			StageManager.scene_change = true
		else:
			Player._swap_attention()
			DialogManager.start_dialog(global_position, lines, speech_sound, false)
			await DialogManager.dialog_finished
			Player._swap_attention()


func _on_stairs_body_exited(_body):
	pass


func _on_bridge_body_entered(body):
	const COMMAND_DECK = preload("res://Scenes/Main floor rooms/command_deck.tscn")
	count += 1
	if body.name == "Player" && count > 1:
		if PositionManager.Act != 1:
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			PositionManager.PrevPosition = body.global_position
			StageManager.changeScene(COMMAND_DECK, 122, 128)
			StageManager.changeCamera(304)
			StageManager.scene_change = true
		else: #Command deck locked for first act 
			Player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound2, false)
			await DialogManager.dialog_finished
			Player._swap_attention()


func _on_bridge_body_exited(_body):
	HasLeft = true


