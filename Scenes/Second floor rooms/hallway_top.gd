extends Node2D

var count = 0

func _on_to_the_transitionary_hallway_body_entered(body):
	count += 1
	if count > 2:
		if body.name == "Player":
			const HALLWAY_TRANS = preload("res://Scenes/Second floor rooms/hallway_transition.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(HALLWAY_TRANS, 152, 118)
			StageManager.changeCamera(304)
			StageManager.scene_change = true


func _on_to_security_room_body_entered(body):
	count += 1
	if count > 2:
		if body.name == "Player":
			const SECURITY_ROOM = preload("res://Scenes/Second floor rooms/security_room.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(SECURITY_ROOM, 204, 146)
			StageManager.changeCamera(312)
			StageManager.scene_change = true


func _on_to_stairs_body_entered(body):
	count += 1
	if count > 2:
		if body.name == "Player":
			const STAIRS = preload("res://Scenes/Main floor rooms/stairs.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(STAIRS, 243, 144)
			StageManager.changeCamera(312)
			StageManager.scene_change = true
