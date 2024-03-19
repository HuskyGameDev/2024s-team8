extends Node2D

var count = 0

func _ready():
	PositionManager.Act = 2

func _on_to_power_station_body_entered(_body):
	count += 1
	if count > 4:
		const POWER_ROOM = preload("res://Scenes/Second floor rooms/power_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(POWER_ROOM, 269, 122)
		StageManager.changeCamera(312)
		StageManager.scene_change = true

func _on_to_bottom_hallway_body_entered(_body):
	count += 1
	if count > 4:
		const HALLWAY_BOT = preload("res://Scenes/Second floor rooms/hallway_bottom.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_BOT, 112, 118)
		StageManager.changeCamera(480)
		StageManager.scene_change = true

func _on_to_top_hallway_body_entered(_body):
	count += 1
	if count > 4:
		const HALLWAY_TOP = preload("res://Scenes/Second floor rooms/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TOP, 88, 145)
		StageManager.changeCamera(480)
		StageManager.scene_change = true


func _on_to_bathroom_body_entered(_body):
	count += 1
	if count > 4:
		var ran = randi_range(0,1)
		var BATHROOM
		if ran == 0:
			BATHROOM = preload("res://Scenes/Second floor rooms/bathroom_with_toilet.tscn")
		else:
			BATHROOM = preload("res://Scenes/Second floor rooms/bathroom_with_shower.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(BATHROOM, 40, 132)
		StageManager.changeCamera(320)
		StageManager.scene_change = true
