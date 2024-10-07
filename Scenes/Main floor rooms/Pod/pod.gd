extends Node2D
var HasLeft = true

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var meatSuit = $"%Meat Suit"
@onready var marker = $Marker2D
@onready var animPlayer = $AnimationPlayer


# REMINDER: Could replace G with + InputMap.action_get_events("OBJECTIVE")[0].as_text() +, after finding out how to remove "(physical)"
var lines: Array[String] = [
	"I should press '" + InputMap.action_get_events("OBJECTIVE")[0].as_text() + "' to look over my notes...", 
	""
]

const lines2: Array[String] = [
	"Time to make the decoy suit. Hopefully this works!"
]

# Called when the node enters the scene tree for the first time.
#Tells player to press G on startup
#checks if act is between 1 and 0? if so sets it to 0
func _ready():
	
	$Heli.visible = false
	meatSuit.visible = false
	if PositionManager.Act < 1:
		PositionManager.Act = 0
	if !PositionManager.HasOpenedTutorial && PositionManager.StartFromBeginning:
		player._swap_attention()
		await get_tree().create_timer(1).timeout
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false, true)
		await DialogManager.dialog_finished
		player._swap_attention()
	
	if PositionManager.HasDefeatedMonster:
		meatSuit.visible = true
	elif PositionManager.HasMeat && PositionManager.HasHeatLamp && PositionManager.HasSpaceSuit:
		player._swap_attention()
		DialogManager.start_dialog(global_position, lines2, speech_sound, false, false)
		await DialogManager.dialog_finished
		meatSuit.visible = true
		PositionManager.HasDefeatedMonster = true
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
		player._swap_attention()
		

#sets the act to 0 if the player walks in the room if they're in act is 1
func _process(_delta):
	if Input.is_action_just_pressed("F") and PositionManager.Act == 3:
		player._swap_attention()
		player.animMove = true
		meatSuit.visible = true
	if PositionManager.Act == 1:
		PositionManager.Act = 0
	if player.animMove:
		var vector = Vector2.ZERO
		var x = marker.position.x - player.position.x
		var y = marker.position.y - player.position.y
		
		if absf(x) > 0.5:
			vector.x = x
		if absf(y) > 0.5:
			vector.y = y
			
		player.animVec = vector

#Switches to airlock scene
func _on_to_hall_body_entered(body):
	if Input.is_action_pressed("DOWN") && body.name == "Player":
		$Player.hasAttention = StageManager.scene_change
		$Player/AnimationTree.set("active", StageManager.scene_change)
		var AIRLOCK = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
		StageManager.player_facing = Vector2(0, 1)
		StageManager.changeScene(AIRLOCK, 155, 110, true)
		StageManager.changeCamera(304)


func _on_player_done_moving() -> void:
	player.animVec = Vector2.ZERO
	player.animMove = false
	animPlayer.play("approach")
	await animPlayer.animation_finished
	PositionManager.heliDistracted = true
	player._swap_attention()
