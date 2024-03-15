extends Node2D

var hasLeft = false


func _on_to_the_transitionary_hallway_body_entered(body):
	const HALLWAY_TRANS = preload("res://Scenes/Second floor rooms/hallway_transition.tscn")
	if hasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TRANS, 152, 142)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


func _on_to_the_transitionary_hallway_body_exited(body):
	hasLeft = true


func _on_landing_area_body_entered(body):
	hasLeft = true
