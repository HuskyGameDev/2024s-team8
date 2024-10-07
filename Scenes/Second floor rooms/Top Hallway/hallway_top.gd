extends Node2D

@onready var Lock = get_tree().get_first_node_in_group("Combo Lock")
@onready var SecurityDoor = get_node("dialDoor")
@onready var StairsDoor = get_tree().get_first_node_in_group("Stairs Door")
@onready var animPlayer = get_node("AnimationPlayer")

var count = 0

func _ready():
	if PositionManager.hasClearedDial:
		if SecurityDoor != null:
			SecurityDoor.queue_free()
	else:
		animPlayer.play("closed")
	
	if !PositionManager.SecurityEnabled:
		StairsDoor.queue_free()


func _on_to_security_room_body_entered(body):
	if body.name == "Player" && Input.is_action_pressed("UP") && PositionManager.hasClearedDial:
		var SECURITY_ROOM = load("res://Scenes/Second floor rooms/Security Room/security_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,-1)
		StageManager.changeScene(SECURITY_ROOM, 141, 147)
		StageManager.changeCamera(312)
		StageManager.scene_change = true


func _on_to_stairs_body_entered(body):	
	if body.name == "Player" && Input.is_action_pressed("UP") && !PositionManager.SecurityEnabled:
		var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,-1)
		StageManager.changeScene(STAIRS, 243, 144)
		StageManager.changeCamera(312)
		StageManager.scene_change = true

func _on_combo_lock_open_door():
	GlobalAudioManager.door_SFX() # Plays door opening SFX
	#animPlayer.play("Sec_Door_Opening")


func _on_dial_door_open_door() -> void:
	GlobalAudioManager.door_SFX() # Plays door opening SFX
	animPlayer.play("opening")
	await animPlayer.animation_finished
	animPlayer.play("open")


func _on_to_power_room_body_entered(body: Node2D) -> void:
	if Input.is_action_pressed("LEFT") && body.name == "Player":
		var POWER_ROOM = load("res://Scenes/Second floor rooms/Power Room/power_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(-1,0)
		StageManager.changeScene(POWER_ROOM, 269, 122)
		StageManager.changeCamera(312)
	pass # Replace with function body.


func _on_to_boiler_room_body_entered(body: Node2D) -> void:
	if Input.is_action_pressed("UP") && body.name == "Player":
		var BOILER_ROOM = load("res://Scenes/Second floor rooms/Boiler Room/boiler_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,-1)
		StageManager.changeScene(BOILER_ROOM, 204, 146)
		StageManager.changeCamera(304)

	pass # Replace with function body.
