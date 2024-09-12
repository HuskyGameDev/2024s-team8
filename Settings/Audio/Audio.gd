extends VBoxContainer

var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
var DIALOGUE_BUS_ID = AudioServer.get_bus_index("Dialogue")
@export var sound_value = .5

# Sets the sliders to their respective positions if they have been altered before
func _ready():
	get_node("%MasterSlider").set_value_no_signal(sound_value)
	get_node("%MusicSlider").set_value_no_signal(sound_value)
	get_node("%SFXSlider").set_value_no_signal(sound_value)
	get_node("%DialogueSlider").set_value_no_signal(sound_value)
	
	
	
# Changes volume of music bus to the music slider value when the music slider is altered
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID,linear_to_db(value))
	
	# Mutes music if slider is < 0.5
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)		

# Changes volume of SFX bus to the SFX slider value when the SFX slider is altered
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID,linear_to_db(value))
	
	# Mutes SFX if slider is < 0.5
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)			

# Changes volume of master bus to the master slider value when the master slider is altered
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID,linear_to_db(value))
	
	# Mutes master volume if slider is < 0.5
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < 0.05)			

# Changes volume of dialogue bus to the dialogue slider value when the dialogue slider is altered
func _on_dialogue_slider_value_changed(value):
	AudioServer.set_bus_volume_db(DIALOGUE_BUS_ID,linear_to_db(value))
	
	# Mutes dialogue volume if slider is < 0.5
	AudioServer.set_bus_mute(DIALOGUE_BUS_ID, value < 0.05)	
