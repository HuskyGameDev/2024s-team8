extends AudioStreamPlayer

const act1_music = preload("res://Assets/Audio/Music/Pro-Hel_Ambiance.mp3")
const act2_music = preload("res://Assets/Audio/Music/Pro-Hel_Ambiance_Act_2.wav")


# Plays the inputted audio stream if it isn't currently playing that stream
func _play_music(music: AudioStream):
	if stream == music:
		return
	
	stream = music
	play()

# function that plays "act 1 music" 
func play_act1_music():
	_play_music(act1_music)
	
	# Guarantees current bus is Music
	if(get_bus() != 'Music'):  
		set_bus('Music')

# function that plays "act 2 music" 
func play_act2_music():
	_play_music(act2_music)
	
	# Guarantees current bus is Music
	if(get_bus() != 'Music'):  
		set_bus('Music')
