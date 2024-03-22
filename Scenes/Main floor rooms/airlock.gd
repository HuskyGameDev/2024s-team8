extends Node2D


var count = 0


func _on_to_hall_body_entered(body):
	count += 1
	if count > 1:
		if body.name == "Player":
			const HALL = preload("res://Scenes/Main floor rooms/hallway_main.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(HALL, 76, 130)
			StageManager.changeCamera(480)
			StageManager.scene_change = true

func _on_to_pod_body_entered(body):
	count += 1
	if count > 1:
		if body.name == "Player":
			const POD = preload("res://Scenes/Main floor rooms/pod.tscn")
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(POD, 148, 136)
			StageManager.changeCamera(304)
			StageManager.scene_change = true
