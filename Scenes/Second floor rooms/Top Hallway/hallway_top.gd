extends Node2D

@onready var Lock = get_tree().get_first_node_in_group("Combo Lock")
@onready var SecurityDoor = get_tree().get_first_node_in_group("Security Door")
@onready var StairsDoor = get_tree().get_first_node_in_group("Stairs Door")
@onready var animPlayer = get_tree().get_first_node_in_group("AnimationPlayer")

var count = 0

func _ready():
	if PositionManager.hasClearedCombo:
		if Lock != null:
			Lock.queue_free()
		if SecurityDoor != null:
			SecurityDoor.queue_free()
	else:
		animPlayer.play("Sec_Closed")
	
	if !PositionManager.SecurityEnabled:
		StairsDoor.queue_free()

func _on_to_the_transitionary_hallway_body_entered(body):
	count += 1
	if count > 2:
		if body.name == "Player":
			var HALLWAY_TRANS = load("res://Scenes/Second floor rooms/Transition Hallway/hallway_transition.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(HALLWAY_TRANS, 152, 118)
			StageManager.changeCamera(304)
			StageManager.scene_change = true


func _on_to_security_room_body_entered(body):
	count += 1
	if count > 2:
		if body.name == "Player":
			var SECURITY_ROOM = load("res://Scenes/Second floor rooms/Security Room/security_room.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(SECURITY_ROOM, 204, 146)
			StageManager.changeCamera(312)
			StageManager.scene_change = true


func _on_to_stairs_body_entered(body):
	count += 1
	if count > 2:
		if body.name == "Player":
			var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(STAIRS, 243, 144)
			StageManager.changeCamera(312)
			StageManager.scene_change = true

func _on_combo_lock_open_door():
	GlobalAudioManager.door_SFX() # Plays door opening SFX
	animPlayer.play("Sec_Door_Opening")
