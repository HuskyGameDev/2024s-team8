# Author: Liam Shahid

extends AudioStreamPlayer

# Plays the door sound effect
func play_door_sfx(sfx: AudioStream):
	stream = sfx
	play()
	
