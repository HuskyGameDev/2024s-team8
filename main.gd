extends Node2D

@export var settingsMenu = preload("res://Scenes/settingsMenu.tscn")

var settings 		# Variable to store a settingsMenu 

func _ready():
	# Plays main menu music when main menu is created
	GlobalAudioManager.play_menu_music()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")
	StageManager.scene_change = true

func _on_quit_pressed():
	get_tree().quit()
	
# Shows nodes in Main 
func _show_nodes():
	$Play.show()
	$Settings.show()
	$Quit.show()
	
# Hides nodes in Main
func _hide_nodes():
	$Play.hide()
	$Settings.hide()
	$Quit.hide()

func _on_settings_pressed():
	# Adds a settingsMenu instance to Main
	settings = settingsMenu.instantiate()
	$SettingsLayer.add_child(settings)
	
	# Hides the nodes currently on screen
	_hide_nodes()
	
	# Shows the nodes on screen once settings is closed
	settings.tree_exited.connect(_show_nodes)
