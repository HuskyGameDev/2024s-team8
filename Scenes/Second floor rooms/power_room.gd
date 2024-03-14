extends Node2D

var hasLeft = false

func _on_door_body_entered(body):
	const HALLWAY_TRANS = preload("res://Scenes/Second floor rooms/hallway_transition.tscn")
	if hasLeft:
		StageManager.changeScene(HALLWAY_TRANS, 80, 144)
		StageManager.changeCamera(304)
		StageManager.scene_change = true



func _on_door_body_exited(body):
	hasLeft = true
