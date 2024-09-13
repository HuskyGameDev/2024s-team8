extends MarginContainer


@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer
@onready var audio_player = $AudioStreamPlayer


const MAX_WIDTH = 256

var text = ""
var letter_index = 0

const letter_time = 0.03 
const space_time = 0.06
const punctuation_time = 0.2


signal finished_displaying()

#displays text given to the funtion as well as playing audio
#wraps text back around once the size.x of the text is greater than the max size given
#calls display letter function
func display_text(text_to_display: String, speech_sfx: AudioStream):
	PositionManager.finished_displaying = false
	text = text_to_display
	label.text = text_to_display
	audio_player.stream = speech_sfx
	
	await resized
	custom_minimum_size.x = min(MAX_WIDTH, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		custom_minimum_size.y = size.y
	
	label.text = ""
	
	display_letter()


#loops through the array of text and displayes it letter by letter stopping after periods, commas
#and other punctuation for a certain amount of time specified
#replays sound every even index in the array
func display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		PositionManager.finished_displaying = true
		return
	
	if (PositionManager.playTextSound):
		match text[letter_index]:
			"!", ".", ",", "?":
				timer.start(float(punctuation_time) / PositionManager.textSpd)
			" ":
				timer.start(float(space_time) / PositionManager.textSpd)
			_:
				timer.start(float(letter_time) / PositionManager.textSpd) 
			
	else:
		match text[letter_index]:
			"!", ".", ",", "?":
				timer.start(0.000000001)
			" ":
				timer.start(0.000000001)
			_:
				timer.start(0.000000001) 
	var new_audio_player = audio_player.duplicate()
	#new_audio_player.volume_db = 20.0
	get_tree().root.add_child(new_audio_player)
	if letter_index % 2 == 0 && PositionManager.playTextSound:
		new_audio_player.play()
		await new_audio_player.finished
	new_audio_player.queue_free()


func _on_letter_display_timer_timeout():
	display_letter()
