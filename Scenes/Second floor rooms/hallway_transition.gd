extends Node2D

var hasLeft = false

func _on_to_power_station_body_entered(body):
	const POWER_ROOM = preload("res://Scenes/Second floor rooms/power_room.tscn")
	if hasLeft:
		StageManager.changeScene(POWER_ROOM, 279, 122)
		StageManager.changeCamera(312)
		StageManager.scene_change = true


func _on_to_power_station_body_exited(body):
	hasLeft = true
