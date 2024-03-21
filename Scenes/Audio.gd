extends VBoxContainer

var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

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
