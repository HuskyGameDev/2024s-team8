extends Node2D


func _on_play_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")
	#const COMMAND_DECK = preload("res://Scenes/Main floor rooms/command_deck.tscn")
	#StageManager.changeScene(COMMAND_DECK, 144, 128)
	#StageManager.changeCamera(304)

func _on_quit_pressed():
	get_tree().quit()
