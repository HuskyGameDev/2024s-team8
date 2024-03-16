extends Node2D

var count = 0

func _on_to_bottom_hallway_body_entered(_body):
	count += 1
	if count > 1:
		const HALLWAY_BOT = preload("res://Scenes/Second floor rooms/hallway_bottom.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_BOT, 388, 122)
		StageManager.changeCamera(480)
		StageManager.scene_change = true
