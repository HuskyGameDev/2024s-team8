extends Node2D

var count = 0

func _on_door_body_entered(_body):
	count += 1
	if count > 1:
		const HALLWAY_TRANS = preload("res://Scenes/Second floor rooms/hallway_transition.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TRANS, 228, 132)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
