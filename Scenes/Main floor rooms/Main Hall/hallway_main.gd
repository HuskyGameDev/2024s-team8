extends Node2D

@onready var Player = get_node("Player")
@onready var StairsDoor = get_tree().get_first_node_in_group("Stairs Door")
@onready var CommandDoor = get_tree().get_first_node_in_group("Command Door")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")

var count = 0


const lines: Array[String] = [
	"This door is locked! I must find another way to reach the second floor."
]

const lines2: Array[String] = [
	"This door is locked!"
]

const lines3: Array[String] = [
	"I've turned off the security. The ships command deck is now unlocked, lets get out of here!"
	]
	
var HasLeft = true

# Called when the node enters the scene tree for the first time.

func _ready():
	#opens the command door
	if PositionManager.Act == 3:
		CommandDoor.queue_free()
		$"Door areas/Bridge".monitoring = true
	
	#sets camera limit
	StageManager.changeCamera(488)
	InteractionManager.player = Player
	
	#sets Player Postition
	if PositionManager.PrevPosition != Vector2.ZERO:
		Player.global_position = PositionManager.PrevPosition
		HasLeft = false
	#Opens stairs when SecturityEnabled is true
	if !PositionManager.SecurityEnabled:
		StairsDoor.queue_free()
	#checks if its not act 1 or 0 and if the player hasn't read the escape text
	if PositionManager.Act != 1 && PositionManager.Act != 0 && !PositionManager.HasReadEscapeText:
		Player._swap_attention()
		HasLeft = true
		PositionManager.HasReadEscapeText = true
		DialogManager.start_dialog(global_position, lines3, speech_sound, false, false)
		await DialogManager.dialog_finished
		Player._swap_attention()
	

#switches to the mess hall scene
func _on_mess_hall_body_entered(body):
	var MESS = load("res://Scenes/Main floor rooms/Mess Hall/mess_hall.tscn")
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

#switches to the research room scene
func _on_research_room_body_entered(body):
	var RESEARCH = load("res://Scenes/Main floor rooms/Research/research1.tscn")
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

#switches to the pod scene
func _on_pod_body_entered(body):
	var AIRLOCK = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
	if body.name == "Player" && HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		PositionManager.PrevPosition = body.global_position
		StageManager.changeScene(AIRLOCK, 158, 126) 
		StageManager.changeCamera(304)
		StageManager.scene_change = true

func _on_pod_body_exited(_body):
	HasLeft = true

#switches to the bunks scene
func _on_bunks_body_entered(body):
	var BUNKS = load("res://Scenes/Main floor rooms/Bunks/bunks.tscn")
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


#switches to the supply closet scene
func _on_supply_closet_body_entered(body):
	var SUPPLY = load("res://Scenes/Main floor rooms/Supply Closet/supply_closet.tscn")
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

#switches to the stairs scene
func _on_stairs_body_entered(body):
	var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
	if body.name == "Player" && HasLeft:
		if PositionManager.Act != 1:
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			PositionManager.PrevPosition = body.global_position
			StageManager.changeScene(STAIRS, 59, 89)
			StageManager.changeCamera(304)
			StageManager.scene_change = true
		else:
			Player._swap_attention()
			DialogManager.start_dialog(global_position, lines, speech_sound, false)
			await DialogManager.dialog_finished
			Player._swap_attention()


func _on_stairs_body_exited(_body):
	HasLeft = true
	pass


#switches to the command deck scene
func _on_bridge_body_entered(body):
	var COMMAND_DECK = load("res://Scenes/Main floor rooms/Command Deck/command_deck.tscn")
	count += 1
	if body.name == "Player" && HasLeft:
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
