extends Node2D

var hasLeft = false

func _on_to_power_station_body_entered(_body):
	const POWER_ROOM = preload("res://Scenes/Second floor rooms/power_room.tscn")
	if hasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(POWER_ROOM, 279, 122)
		StageManager.changeCamera(312)
		StageManager.scene_change = true

func _on_to_power_station_body_exited(_body):
	hasLeft = true

func _on_to_bottom_hallway_body_entered(_body):
	const HALLWAY_BOT = preload("res://Scenes/Second floor rooms/hallway_bottom.tscn")
	if hasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_BOT, 112, 118)
		StageManager.changeCamera(480)
		StageManager.scene_change = true

func _on_to_bottom_hallway_body_exited(_body):
	hasLeft = true

func _on_to_top_hallway_body_entered(body):
	const HALLWAY_TOP = preload("res://Scenes/Second floor rooms/hallway_top.tscn")
	if hasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TOP, 86, 144)
		StageManager.changeCamera(480)
		StageManager.scene_change = true

func _on_to_top_hallway_body_exited(body):
	hasLeft = true
