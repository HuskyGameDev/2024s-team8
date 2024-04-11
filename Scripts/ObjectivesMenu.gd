extends Control


func _ready():
	if !PositionManager.HasOpenedTutorial:
		PositionManager.HasOpenedTutorial = true
	
	setLabels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Closes settings Menu if "MENU" is pressed
	if Input.is_action_just_pressed("MENU") or Input.is_action_just_pressed("OBJECTIVE"):
		_on_exit_button_pressed()

# Closes settingsMenu if exit button is pressed
func _on_exit_button_pressed():
	queue_free()


func _on_button_pressed():
	queue_free()
	pass # Replace with function body.

# Sets the labels to current keybinds
func setLabels():
	%Label.text = " - Use '" + InputMap.action_get_events("UP")[0].as_text() + InputMap.action_get_events("LEFT")[0].as_text() + InputMap.action_get_events("DOWN")[0].as_text() + InputMap.action_get_events("RIGHT")[0].as_text() +"' to move."
	%Label2.text = " - Press '" + InputMap.action_get_events("INTERACT")[0].as_text() + "' to interact."  
	%Label5.text = "- Hold '" + InputMap.action_get_events("SHIFT")[0].as_text() + "' to sprint."
	%Label3.text = " - Press '" + InputMap.action_get_events("MAP")[0].as_text() + "' to open the map."
	%Label6.text = " - Press '" + InputMap.action_get_events("OBJECTIVE")[0].as_text() + "' to open the objectives."
