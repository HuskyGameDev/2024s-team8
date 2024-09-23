extends Node2D

var count = 0
@onready var animPlayer = $AnimationPlayer
@onready var poweredDoor = get_tree().get_first_node_in_group("P-Door")
@onready var door = $Door

func _ready():
	if PositionManager.Act == 1 and animPlayer != null:
		door.monitoring = false
		animPlayer.play("Closed")
		$Player._swap_attention()
		$Player/AnimationPlayer.play("Left")
		animPlayer.play("Enter Act 2")
		await animPlayer.animation_finished
		animPlayer.play("Wake up")
		await animPlayer.animation_finished
		$Player._swap_attention()
	else:
		print("Pooey")
	
	if PositionManager.hasClearedPipe:
		if poweredDoor != null:
			poweredDoor.queue_free()
			door.monitoring = true
			count += 1
		

func _on_door_body_entered(_body):
	count += 1
	if count > 2:
		var HALLWAY_TRANS = load("res://Scenes/Second floor rooms/Transition Hallway/hallway_transition.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false) 
		StageManager.changeScene(HALLWAY_TRANS, 72, 132)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


func _on_pipe_opening():
	door.monitoring = true
	GlobalAudioManager.door_SFX() # Plays door opening SFX
	animPlayer.play("Door_Opening")
