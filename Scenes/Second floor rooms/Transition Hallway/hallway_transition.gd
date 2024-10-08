extends Node2D

var count = 0

func _on_to_power_station_body_entered(_body):
	count += 1
	if count > 4:
		var POWER_ROOM = load("res://Scenes/Second floor rooms/Power Room/power_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(POWER_ROOM, 269, 122)
		StageManager.changeCamera(312)
		StageManager.scene_change = true

func _on_to_bottom_hallway_body_entered(_body):
	count += 1
	if count > 4:
		var HALLWAY_BOT = load("res://Scenes/Second floor rooms/Bottom Hallway/hallway_bottom.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_BOT, 112, 118)
		StageManager.changeCamera(488)
		StageManager.scene_change = true

func _on_to_top_hallway_body_entered(_body):
	count += 1
	if count > 4:
		var HALLWAY_TOP = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TOP, 88, 145)
		StageManager.changeCamera(488)
		StageManager.scene_change = true


func _on_to_bathroom_body_entered(_body):
	if _body == "Player" && Input.is_action_pressed("RIGHT"):
		var ran = randi_range(0,1)
		var BATHROOM
		if ran == 0:
			BATHROOM = load("res://Scenes/Second floor rooms/Bathroom/bathroom_with_toilet.tscn")
		else:
			BATHROOM = load("res://Scenes/Second floor rooms/Bathroom/bathroom_with_shower.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(BATHROOM, 40, 132)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
