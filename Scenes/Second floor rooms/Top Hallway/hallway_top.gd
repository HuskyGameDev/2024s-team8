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

func _on_to_the_transitionary_hallway_body_entered(body):
	
	if Input.is_action_pressed("DOWN") && body.name == "Player":
		var HALLWAY_TRANS = load("res://Scenes/Second floor rooms/Transition Hallway/hallway_transition.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TRANS, 152, 118)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


func _on_to_security_room_body_entered(body):
	if body.name == "Player" && Input.is_action_pressed("UP"):
		var SECURITY_ROOM = load("res://Scenes/Second floor rooms/Security Room/security_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(SECURITY_ROOM, 204, 146)
		StageManager.changeCamera(312)
		StageManager.scene_change = true


func _on_to_stairs_body_entered(body):
	
	if body.name == "Player" && Input.is_action_pressed("UP"):
		var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
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
