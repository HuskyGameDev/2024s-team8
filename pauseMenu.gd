extends Control

@export var settingsMenu = preload("res://Scenes/settingsMenu.tscn")

var settings 		# Variable to store a settingsMenu 
var focus = true	# Whether or not the focus is on Pause Screen

func _on_resume_pressed():
	queue_free()
	
func _on_quit_pressed():
	get_tree().quit()

func _process(_delta):
	
	if Input.is_action_just_pressed("MENU"):
		if(focus == true):
			_on_resume_pressed()

# Shows nodes in Pause Screen
func _show_nodes():
	$Resume.show()
	$Settings.show()
	$Quit.show()
	$Background.show()
	
	focus = true		# Focus is moved back to Pause Screen
	
# Hides nodes in Pause Screen
func _hide_nodes():
	$Resume.hide()
	$Settings.hide()
	$Quit.hide()
	$Background.hide()
	
	focus = false		# Focus is moved to another scene

func _on_settings_pressed():
	# Adds a settingsMenu instance to Pause Screen
	settings = settingsMenu.instantiate()
	$SettingsLayer.add_child(settings)
	
	# Hides the nodes currently on screen
	_hide_nodes()
	
	# Shows the nodes on screen once settings is closed
	settings.tree_exited.connect(_show_nodes)
	
	
	
