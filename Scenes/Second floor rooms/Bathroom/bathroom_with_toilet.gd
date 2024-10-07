extends Node2D



func _on_door_body_entered(_body):
	if _body.name == "Player" && Input.is_action_pressed("LEFT"):
		var HALLWAY_TRANS = load("res://Scenes/Second floor rooms/Transition Hallway/hallway_transition.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(-1,0)
		StageManager.changeScene(HALLWAY_TRANS, 228, 132)
		StageManager.changeCamera(304)
