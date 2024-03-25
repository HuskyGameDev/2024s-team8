extends Control


func _ready():
	if !PositionManager.HasOpenedTutorial:
		PositionManager.HasOpenedTutorial = true

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
