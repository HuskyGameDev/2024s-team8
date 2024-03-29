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


func display_text(text_to_display: String, speech_sfx: AudioStream):
	text = text_to_display
	label.text = text_to_display
	audio_player.stream = speech_sfx
	
	await resized
	custom_minimum_size.x = min(MAX_WIDTH, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	
	global_position.x += 64
	label.text = ""
	display_letter()

func display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time) 
			
			var new_audio_player = audio_player.duplicate()
			#new_audio_player.pitch_scale += randf_range(-0.1, 0.1)
			#if text[letter_index] in ["a", "e", "i", "o", "u"]:
				#new_audio_player.pitch_scale += 0.2
			get_tree().root.add_child(new_audio_player)
			if letter_index % 2 == 0:
				new_audio_player.play()
				await new_audio_player.finished
			new_audio_player.queue_free()


func _on_letter_display_timer_timeout():
	display_letter()

