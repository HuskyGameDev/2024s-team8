extends Node2D


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")
@onready var meatSuit = $"%Meat Suit"
@onready var marker = $Marker2D
@onready var animPlayer = get_tree().get_first_node_in_group("AnimationPlayer")

var decoyPlaced = false

var vector = Vector2.ZERO
var x
var y



var lines: Array[String] = [
	"No matter how many times I do this, it's still difficult getting used to my new 'home'.",
	"That reminds me, I better make sure to press '" + InputMap.action_get_events("INTERACT")[0].as_text() + "' to interact with objects around me."
]

const lines2: Array[String] = [
	"Time to make the decoy suit. Hopefully this works!"
]

const lines3: Array[String] = [
	"You hear something approaching from the outside of the room...",
	"Better find somewhere to hide."
]

# Called when the node enters the scene tree for the first time.
#Tells player to press G on startup
#checks if act is between 1 and 0? if so sets it to 0
func _ready():
	
	PositionManager.hasDecoy = PositionManager.HasMeat and PositionManager.HasSpaceSuit and PositionManager.HasHeatLamp
	$Heli.visible = false
	meatSuit.visible = false
	if PositionManager.Act < 1:
		PositionManager.Act = 0
	if PositionManager.StartFromBeginning && !PositionManager.HasOpenedTutorial:
		if $Player.hasAttention == true:
			player._swap_attention()
		await get_tree().create_timer(1).timeout
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
		await DialogManager.dialog_finished
		PositionManager.HasOpenedTutorial = true
		PositionManager.add_objective("Explore Ship", "Get accustomed to your new home.")
		PositionManager.add_objective("Meet Crewmates", "Meet the fellow crewmates.")
		if $Player.hasAttention == false:
			player._swap_attention()

	if PositionManager.hasDecoy:
		PositionManager.performingDecoy = true
		if $Player.hasAttention:
			player.hasAttention = false
			
		DialogManager.start_dialog(global_position, lines2, speech_sound, false, false)
		await DialogManager.dialog_finished
		
		player.animMove = true
		_move_player_to_marker(marker)
		
		
		

#sets the act to 0 if the player walks in the room if they're in act is 1
func _process(_delta):
	
	if PositionManager.Act == 1:
		PositionManager.Act = 0
	
	
	x = marker.position.x - player.position.x
	y = marker.position.y - player.position.y
	vector = Vector2(x,y)
	
	player.animVec = vector
	if player.animMove:
		_move_player_to_marker(marker)
	
	if !PositionManager.heliDistracted and PositionManager.Act == 3 and decoyPlaced and player.hiding:
			PositionManager.heliDistracted = true
			await get_tree().create_timer(0.75).timeout
			animPlayer.play("approach")

#Switches to airlock scene
func _on_to_hall_body_entered(body):
	if Input.is_action_pressed("DOWN") && body.name == "Player":
		if decoyPlaced and !PositionManager.heliDistracted:
			player._swap_attention()
			DialogManager.start_dialog(global_position, lines3, speech_sound2, false, false)
			await DialogManager.dialog_finished
			player._swap_attention()
		else:
			$Player.hasAttention = StageManager.scene_change
			$Player/AnimationTree.set("active", StageManager.scene_change)
			var AIRLOCK = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
			StageManager.player_facing = Vector2(0, 1)
			StageManager.changeScene(AIRLOCK, 155, 105, true)
			StageManager.changeCamera(304)


func _move_player_to_marker(m: Node2D)->void:
	if absf(vector.x) <= 1 && absf(vector.y) <= 1:
		player.animVec = Vector2.ZERO
		vector = Vector2.ZERO
	else:
		x = m.position.x - player.position.x
		y = m.position.y - player.position.y
		vector = Vector2(x,y)


func place_decoy():
	meatSuit.visible = true
	decoyPlaced = true
	var i = 0
	for item in PositionManager.Inventory:
		if item == "SpaceSuit" or item == "Meat" or item == "HeatLamp":
			PositionManager.InventoryText.remove_at(i)
			PositionManager.InventorySprite.remove_at(i)
			i -= 1
		i += 1
	PositionManager.Inventory.erase("SpaceSuit")
	PositionManager.Inventory.erase("Meat")
	PositionManager.Inventory.erase("HeatLamp")


func _on_player_done_moving() -> void:
	if player.hasAttention:
		player.hasAttention = false
	player.animVec = Vector2.ZERO
	player.animMove = false
	place_decoy()
	await get_tree().create_timer(0.75).timeout
	DialogManager.start_dialog(global_position, lines3, speech_sound2, false, false)
	await DialogManager.dialog_finished
	if !player.hasAttention:
		player.hasAttention = true
