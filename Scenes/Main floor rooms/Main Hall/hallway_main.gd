extends Node2D

@onready var Player = get_node("Player")
@onready var StairsDoor = get_tree().get_first_node_in_group("Stairs Door")
@onready var CommandDoor = get_tree().get_first_node_in_group("Command Door")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")



const lines: Array[String] = [
	"This door is locked! I must find another way to reach the second floor."
]

const lines2: Array[String] = [
	"This door is locked!"
]

const lines3: Array[String] = [
	"I've turned off the security. The ships command deck is now unlocked, lets get out of here!"
	]
	

# Called when the node enters the scene tree for the first time.

func _ready():
	
	#sets camera limit
	StageManager.changeCamera(304)
	
	#opens the command door
	if PositionManager.Act == 3:
		CommandDoor.queue_free()
		$"Door areas/Bridge".monitoring = true
	
	InteractionManager.player = Player
	
	#Opens stairs when SecturityEnabled is true
	if !PositionManager.SecurityEnabled:
		StairsDoor.queue_free()
		
	#checks if its not act 1 or 0 and if the player hasn't read the escape text
	if PositionManager.Act != 1 && PositionManager.Act != 0 && !PositionManager.HasReadEscapeText:
		Player._swap_attention()
		PositionManager.HasReadEscapeText = true
		DialogManager.start_dialog(global_position, lines3, speech_sound, false, false)
		await DialogManager.dialog_finished
		Player._swap_attention()
	

#switches to the mess hall scene
func _on_mess_hall_body_entered(body):
	if Input.is_action_pressed("DOWN"):
		var MESS = load("res://Scenes/Main floor rooms/Mess Hall/mess_hall.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(MESS, 232, 120)
			StageManager.scene_change = true

func _on_mess_hall_body_exited(_body):
	
	pass # Replace with function body.

#switches to the research room scene
func _on_research_room_body_entered(body):
	if Input.is_action_pressed("DOWN"):
		var RESEARCH = load("res://Scenes/Main floor rooms/Research/research1.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(RESEARCH, 80, 128)
			StageManager.scene_change = true

func _on_research_room_body_exited(_body):
	
	pass # Replace with function body.

#switches to the pod scene
func _on_pod_body_entered(body):
	if Input.is_action_pressed("UP"):
		var AIRLOCK = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(AIRLOCK, 158, 126) 
			StageManager.scene_change = true

func _on_pod_body_exited(_body):
	pass

#switches to the bunks scene
func _on_bunks_body_entered(body):
	if Input.is_action_pressed("UP"):
		var BUNKS = load("res://Scenes/Main floor rooms/Bunks/bunks.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(BUNKS, 53, 144)
			StageManager.scene_change = true
	
func _on_bunks_body_exited(_body):
	pass # Replace with function body.


#switches to the supply closet scene
func _on_supply_closet_body_entered(body):
	if Input.is_action_pressed("UP"):
		var SUPPLY = load("res://Scenes/Main floor rooms/Supply Closet/supply_closet.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(SUPPLY, 124, 116)
			StageManager.scene_change = true

func _on_supply_closet_body_exited(_body):
	pass # Replace with function body.

#switches to the stairs scene
func _on_stairs_body_entered(body):
	var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
	if body.name == "Player":
		if PositionManager.Act != 1 && Input.is_action_pressed("UP"):
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(STAIRS, 59, 89)
			StageManager.scene_change = true
		else:
			Player._swap_attention()
			DialogManager.start_dialog(global_position, lines, speech_sound, false)
			await DialogManager.dialog_finished
			Player._swap_attention()


func _on_stairs_body_exited(_body):
	pass


#switches to the command deck scene
func _on_bridge_body_entered(body):
	if Input.is_action_pressed("RIGHT"):
		var COMMAND_DECK = load("res://Scenes/Main floor rooms/Command Deck/command_deck.tscn")
		if body.name == "Player":
			if PositionManager.Act != 1:
				$Player.hasAttention = false
				$Player/AnimationTree.set("active", false)
				StageManager.changeScene(COMMAND_DECK, 122, 128)
				StageManager.scene_change = true
			else: #Command deck locked for first act 
				Player._swap_attention()
				DialogManager.start_dialog(global_position, lines2, speech_sound2, false)
				await DialogManager.dialog_finished
				Player._swap_attention()


func _on_bridge_body_exited(_body):
	pass


func _on_mess_hall_left_body_entered(body):
	if Input.is_action_pressed("DOWN"):
		if body.name == "Player":
			var MESS = load("res://Scenes/Main floor rooms/Mess Hall/mess_hall.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(MESS, 61, 115)
			StageManager.scene_change = true
	pass # Replace with function body.


#small bug when leaving the airlock if you hold down you go into this door somehow
func _on_to_research_right_body_entered(body: Node2D) -> void:
		if body.name == "Player" && Input.is_action_pressed("DOWN"):
			var RESEARCH = load("res://Scenes/Main floor rooms/Research/research1.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(RESEARCH, 225, 116)
			StageManager.scene_change = true
			pass # Replace with function body.
