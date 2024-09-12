# Author: Liam Shahid

extends AudioStreamPlayer

const act1_music = preload("res://Assets/Audio/Music/Pro-Hel_Ambiance.mp3")
const act2_music = preload("res://Assets/Audio/Music/Pro-Hel_Ambiance_Act_2.wav")
const menu_music = preload("res://Assets/Audio/Music/Menu Music.wav")
const door_sfx = preload("res://Assets/Audio/Sound Effects/PS_pneumaDoor2.mp3")


# Plays the inputted audio stream if it isn't currently playing that stream
func _play_music(music: AudioStream):
	if stream == music:
		return
	
	stream = music
	play()

# function that plays "act 1 music" 
func play_act1_music():
	_play_music(act1_music)
	
	check_bus()

# function that plays "act 2 music" 
func play_act2_music():
	_play_music(act2_music)
	
	check_bus()
		
# function that plays "menu music" 
func play_menu_music():
	_play_music(menu_music)
	
	check_bus()
	
func check_bus():
	# Guarantees current bus is Music
	if(get_bus() != 'Music'):  
		set_bus('Music')

# Calls the play_door_sfx function of GlobalSFXPlayer
func door_SFX():
	get_node("GlobalSFXPlayer").play_door_sfx(door_sfx)
