extends Node2D

var count = 0

func _on_to_top_hallway_body_entered(_body):
	count += 1
	if count > 1:
		const HALLWAY_TOP = preload("res://Scenes/Second floor rooms/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TOP, 404, 122)
		StageManager.changeCamera(488)
		StageManager.scene_change = true
