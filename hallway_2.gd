extends Node2D




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		StageManager.changeScene(StageManager.HALLWAY_1, 120, 550)
