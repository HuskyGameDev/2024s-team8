extends Node2D


func _on_play_pressed():
	const HALLWAY_MAIN = preload("res://Scenes/hallway_main.tscn")
	StageManager.changeScene(HALLWAY_MAIN, 442, 131)
	StageManager.changeCamera(488)

func _on_quit_pressed():
	get_tree().quit()
