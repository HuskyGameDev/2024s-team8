extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Closes settingsMenu if "MENU" is pressed
	if Input.is_action_just_pressed("MENU"):
		_on_exit_button_pressed()

# Closes settingsMenu if exit button is pressed
func _on_exit_button_pressed():
	queue_free()
