extends Node2D


func _on_play_pressed():
	const HALLWAY_MAIN = preload("res://Scenes/Main floor rooms/hallway_main.tscn")
	StageManager.changeScene(HALLWAY_MAIN, 442, 131)

func _on_quit_pressed():
	get_tree().quit()
