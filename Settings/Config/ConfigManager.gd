extends Node


var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "res://Settings/Config/setting.ini"


func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "UP", "W")
		config.set_value("keybinding", "LEFT", "A")
		config.set_value("keybinding", "DOWN", "S")
		config.set_value("keybinding", "RIGHT", "D")
		config.set_value("keybinding", "INTERACT", "E")
		config.set_value("keybinding", "MENU", "Escape")
		config.set_value("keybinding", "MAP", "M")
		config.set_value("keybinding", "OBJECTIVE", "G")
		config.set_value("keybinding", "SHIFT", "Shift")
		
		config.set_value("audio", "master_volume", 0.5)
		config.set_value("audio", "music_volume", 0.5)
		config.set_value("audio", "sfx_volume", 0.5)
		config.set_value("audio", "dialogue_volume", 0.5)
		
		config.set_value("gameplay", "text_speed", 1)
		
		config.save(SETTINGS_FILE_PATH)
		
	else:
		config.load(SETTINGS_FILE_PATH)
		


func save_keybinding(action: StringName, event : InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouseButton:
		event_str = "mouse_" + str(event.button_index)
	
	config.set_value("keybinding", action, event_str)
	config.save(SETTINGS_FILE_PATH)


func load_keybinding():
	var keybindings = {}
	var keys = config.get_section_keys("keybinding")
	
	for key in keys:
		var input_event 
		var event_str = config.get_value("keybinding", key)
		
		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
		
		keybindings[key] = input_event
	
	return keybindings


func save_audio(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)


func load_audio():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings


func save_gameplay(key: String, value):
	config.set_value("gameplay", key, value)
	config.save(SETTINGS_FILE_PATH)


func load_gameplay():
	var gameplay_settings = {}
	for key in config.get_section_keys("gameplay"):
		gameplay_settings[key] = config.get_value("gameplay", key)
	return gameplay_settings