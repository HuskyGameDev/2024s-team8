extends VBoxContainer

var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
var DIALOGUE_BUS_ID = AudioServer.get_bus_index("Dialogue")
var defaultSound = 0.5
@onready var masterSlider = %MasterSlider
@onready var musicSlider = %MusicSlider
@onready var sfxSlider = %SFXSlider
@onready var dialogueSlider = %DialogueSlider
@onready var audio_player = %AudioStreamPlayer
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var blip_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var sfx_sound = preload("res://Assets/Audio/Sound Effects/PS_pneumaDoor2.mp3")
@onready var music_sound = preload("res://Assets/Dialogue blip5.mp3")


# Sets the sliders to their respective positions if they have been altered before
func _ready():
	get_node("%MasterSlider").set_value_no_signal(PositionManager.masterVolume)
	get_node("%MusicSlider").set_value_no_signal(PositionManager.musicVolume)
	get_node("%SFXSlider").set_value_no_signal(PositionManager.sfxVolume)
	get_node("%DialogueSlider").set_value_no_signal(PositionManager.dialogueVolume)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID,linear_to_db(PositionManager.musicVolume))
	AudioServer.set_bus_volume_db(SFX_BUS_ID,linear_to_db(PositionManager.sfxVolume))
	AudioServer.set_bus_volume_db(MASTER_BUS_ID,linear_to_db(PositionManager.masterVolume))
	AudioServer.set_bus_volume_db(DIALOGUE_BUS_ID,linear_to_db(PositionManager.dialogueVolume))
	
	
# Changes volume of music bus to the music slider value when the music slider is altered
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID,linear_to_db(value))
	PositionManager.musicVolume = value
	play_audio(music_sound, "Music")
	# Mutes music if slider is < 0.5
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)		
	

# Changes volume of SFX bus to the SFX slider value when the SFX slider is altered
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID,linear_to_db(value))
	PositionManager.sfxVolume = value
	play_audio(sfx_sound, "SFX")
	# Mutes SFX if slider is < 0.5
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)			

# Changes volume of master bus to the master slider value when the master slider is altered
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID,linear_to_db(value))
	PositionManager.masterVolume = value
	play_audio(blip_sound, "Master")
	# Mutes master volume if slider is < 0.5
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < 0.05)			

# Changes volume of dialogue bus to the dialogue slider value when the dialogue slider is altered
func _on_dialogue_slider_value_changed(value):
	AudioServer.set_bus_volume_db(DIALOGUE_BUS_ID,linear_to_db(value))
	PositionManager.dialogueVolume = value
	play_audio(speech_sound, "Dialogue")
	# Mutes dialogue volume if slider is < 0.5
	AudioServer.set_bus_mute(DIALOGUE_BUS_ID, value < 0.05)	

func play_audio(audio, bus):
	if PositionManager.ConfigLoaded:
		var new_audio_player = audio_player.duplicate()
		new_audio_player.stream = audio
		new_audio_player.bus = bus
		get_tree().root.add_child(new_audio_player)
		new_audio_player.play()
		await new_audio_player.finished
		new_audio_player.queue_free()


func _on_reset_sound_pressed() -> void:
	ConfigManager.save_audio("master_volume", defaultSound)
	ConfigManager.save_audio("music_volume", defaultSound)
	ConfigManager.save_audio("sfx_volume", defaultSound)
	ConfigManager.save_audio("dialogue_volume", defaultSound)
	PositionManager.masterVolume = defaultSound
	PositionManager.musicVolume = defaultSound
	PositionManager.sfxVolume = defaultSound
	PositionManager.dialogueVolume = defaultSound
	PositionManager.ConfigLoaded = false
	masterSlider.value = defaultSound
	musicSlider.value = defaultSound
	sfxSlider.value = defaultSound
	dialogueSlider.value = defaultSound
	PositionManager.ConfigLoaded = true
