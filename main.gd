extends Node2D


func _on_play_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")
	StageManager.scene_change = true

func _on_quit_pressed():
	get_tree().quit()
