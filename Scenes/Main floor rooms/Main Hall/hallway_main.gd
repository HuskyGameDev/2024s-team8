extends Node2D

@onready var Player = get_node("Player")
@onready var StairsDoor = get_tree().get_first_node_in_group("Stairs Door")
@onready var CommandDoor = get_tree().get_first_node_in_group("Command Door")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")
@onready var flower = $Flower
@onready var path = $FlowerPath

const lines: Array[String] = [
	"This door is locked! I must find another way to reach the second floor."
]

const lines2: Array[String] = [
	"This door is locked!"
]

const lines3: Array[String] = [
	"I need to find a way to get rid of that monster!",
	"If I can lure it to the pod, I could lock the doors and then eject the threat.",
	"But what would lure it?"
]

# Called when the node enters the scene tree for the first time.

func _ready():
	
	PositionManager.hasDecoy = PositionManager.HasMeat and PositionManager.HasSpaceSuit and PositionManager.HasHeatLamp
	
	if PositionManager.Objectives.find("Turn Power On") == -1 && PositionManager.Act != 3:
		PositionManager.add_objective("Turn Power On", "Find out how to turn the power back on.")
	
	path.visible = false
	
	if PositionManager.Act == 3 and !PositionManager.HasDefeatedMonster:
		flower.visible = false
		PositionManager.paused = false
		%Lamps.hide()
		flower.position = path.points[PositionManager.destOrder[PositionManager.dest]] - PositionManager.HelianthRelativePosition
		if PositionManager.destOrder[PositionManager.dest] < 8:
			flower.visible = false
		else:
			flower.visible = true
			flower.monitoring = true
	elif PositionManager.Act != 3:
		flower.visible = false
	
	
	
	#sets camera limit
	StageManager.changeCamera(304)
	
	InteractionManager.player = Player
	
	#Opens stairs when SecturityEnabled is true
	if !PositionManager.SecurityEnabled:
		StairsDoor.queue_free()
		$"Command Door".queue_free()
		$"Door areas/Bridge".monitoring = true
		
	#checks if its not act 1 or 0 and if the player hasn't read the escape text
	if PositionManager.Act != 1 && PositionManager.Act != 0 && !PositionManager.HasReadEscapeText:
		Player.hasAttention = false
		PositionManager.paused = true
		Player.animationTree.set("active", Player.hasAttention)
		PositionManager.HasReadEscapeText = true
		DialogManager.start_dialog(global_position, lines3, speech_sound, false, false)
		await DialogManager.dialog_finished
		PositionManager.paused = false
		PositionManager.add_objective("Create Decoy", "Construct a decoy capable of luring\n the monster.")
		Player.hasAttention = true
		Player.animationTree.set("active", Player.hasAttention)
		
	
	#if PositionManager.HasDefeatedMonster:
		##opens the commands door
		#CommandDoor.queue_free()
		#$"Door areas/Bridge".monitoring = true
	
func _process(_delta):
	if PositionManager.Act == 3 and !PositionManager.HasDefeatedMonster:
		if !PositionManager.paused:
			moving()
		else:
			flower.dir = Vector2.ZERO
			print("Stopped")

func moving():
	
	var destCoord = path.points[PositionManager.destOrder[PositionManager.dest]]
	PositionManager.HelianthRelativePosition = destCoord - flower.position
	if PositionManager.HelianthRelativePosition.length() < 1:
		if PositionManager.destOrder[PositionManager.dest] == 8:
			flower.visible = !flower.visible
		PositionManager.dest += 1
		PositionManager.dest = PositionManager.dest % PositionManager.destOrder.size()
		
	flower.dir = PositionManager.HelianthRelativePosition
	
	await get_tree().create_timer(1.0).timeout

#switches to the mess hall scene
func _on_mess_hall_body_entered(body):
	if Input.is_action_pressed("DOWN"):
		var MESS = load("res://Scenes/Main floor rooms/Mess Hall/mess_hall.tscn")
		if body.name == "Player":
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, 1)
			StageManager.changeScene(MESS, 232, 115)
	


func _on_mess_hall_left_body_entered(body):
	if Input.is_action_pressed("DOWN"):
		if body.name == "Player":
			var MESS = load("res://Scenes/Main floor rooms/Mess Hall/mess_hall.tscn")
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, 1)
			StageManager.changeScene(MESS, 61, 115)




#switches to the research room scene
func _on_research_room_body_entered(body):
	if Input.is_action_pressed("DOWN") && body.name == "Player":
			#$Player._swap_attention()
			#DialogManager.start_dialog(global_position, lines2, speech_sound2, false)
			#await DialogManager.dialog_finished
			#$Player._swap_attention()
			var RESEARCH = load("res://Scenes/Main floor rooms/Research/research1.tscn")
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, 1)
			StageManager.changeScene(RESEARCH, 84, 120)



#small bug when leaving the airlock if you hold down you go into this door somehow
func _on_to_research_right_body_entered(body: Node2D) -> void:
		if body.name == "Player" && Input.is_action_pressed("DOWN"):
			#$Player._swap_attention()
			#DialogManager.start_dialog(global_position, lines2, speech_sound2, false)
			#await DialogManager.dialog_finished
			#$Player._swap_attention()
			var RESEARCH = load("res://Scenes/Main floor rooms/Research/research1.tscn")
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, 1)
			StageManager.changeScene(RESEARCH, 225, 116)




#switches to the pod scene
func _on_pod_body_entered(body):
	if Input.is_action_pressed("UP"):
		var AIRLOCK = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
		if body.name == "Player":
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, -1)
			StageManager.changeScene(AIRLOCK, 158, 130) 


#switches to the bunks scene
func _on_bunks_body_entered(body):
	if Input.is_action_pressed("UP"):
		var BUNKS = load("res://Scenes/Main floor rooms/Bunks/bunks.tscn")
		if body.name == "Player":
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, -1)
			StageManager.changeScene(BUNKS, 53, 144)


#switches to the supply closet scene
func _on_supply_closet_body_entered(body):
	if Input.is_action_pressed("UP"):
		var SUPPLY = load("res://Scenes/Main floor rooms/Supply Closet/supply_closet.tscn")
		if body.name == "Player":
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, -1)
			StageManager.changeScene(SUPPLY, 124, 123)




#switches to the stairs scene
func _on_stairs_body_entered(body):
	var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
	if body.name == "Player":
		if PositionManager.Act != 1 && Input.is_action_pressed("UP"):
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(0, -1)
			StageManager.changeScene(STAIRS, 59, 89)

		else:
			Player._swap_attention()
			DialogManager.start_dialog(global_position, lines, speech_sound, false)
			await DialogManager.dialog_finished
			Player._swap_attention()



#switches to the command deck scene
func _on_bridge_body_entered(body):
	if Input.is_action_pressed("RIGHT") && body.name == "Player":
		var COMMAND_DECK = load("res://Scenes/Main floor rooms/Command Deck/command_deck.tscn")
		if body.name == "Player":
			PositionManager.paused = true
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(1, 0)
			StageManager.changeScene(COMMAND_DECK, 119, 123)
