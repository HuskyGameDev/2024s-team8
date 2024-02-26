extends Node2D

func _on_animation_player_animation_finished(_anim_name):
	const COMMAND_DECK = preload("res://Scenes/Main floor rooms/command_deck.tscn")
	StageManager.changeScene(COMMAND_DECK, 144, 128)
	StageManager.changeCamera(304)
