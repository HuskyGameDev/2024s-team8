extends Node2D

var count = 0

func _on_to_top_hallway_body_entered(_body):
	
	if _body.name == "Player" && Input.is_action_pressed("DOWN"):
		var HALLWAY_TOP = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TOP, 86, 115)
		StageManager.changeCamera(488)
		StageManager.scene_change = true
