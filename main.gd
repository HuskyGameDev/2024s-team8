extends Node2D

func _on_play_pressed():
	StageManager.changeScene(StageManager.HALLWAY_MAIN, 442, 131)

func _on_quit_pressed():
	get_tree().quit()
