extends Node2D

@export var settingsMenu = preload("res://Settings/settingsMenu.tscn")
var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
var DIALOGUE_BUS_ID = AudioServer.get_bus_index("Dialogue")

var settings 		# Variable to store a settingsMenu 

func _ready():
	# Plays main menu music when main menu is created
	load_keybindings_from_settings()
	
	var audio_settings = ConfigManager.load_audio()
	PositionManager.masterVolume = audio_settings.master_volume
	PositionManager.musicVolume = audio_settings.music_volume
	PositionManager.sfxVolume = audio_settings.sfx_volume
	PositionManager.dialogueVolume = audio_settings.dialogue_volume
	
	var gameplay_settings = ConfigManager.load_gameplay()
	PositionManager.textSpd = gameplay_settings.text_speed
	
	AudioServer.set_bus_volume_db(MASTER_BUS_ID,linear_to_db(PositionManager.masterVolume))
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID,linear_to_db(PositionManager.musicVolume))
	AudioServer.set_bus_volume_db(SFX_BUS_ID,linear_to_db(PositionManager.sfxVolume))
	AudioServer.set_bus_volume_db(DIALOGUE_BUS_ID,linear_to_db(PositionManager.dialogueVolume))
	GlobalAudioManager.play_menu_music()
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Transition Scenes/intro.tscn")
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

func load_keybindings_from_settings():
	var keybindings = ConfigManager.load_keybinding()
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keybindings[action])
