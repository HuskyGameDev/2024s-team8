extends Node2D




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		StageManager.changeScene(StageManager.HALLWAY_1, 120, 550)
		#change camera limits
		var cam = body.get_child(Camera2D)
		cam.limit_left = 0
		cam.limit_right = 496
		cam.limit_top = 0
		cam.limit_bottom.set(160);
	
