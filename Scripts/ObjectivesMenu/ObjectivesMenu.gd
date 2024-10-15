extends Control

@onready var Documents = get_tree().get_first_node_in_group("Documents")
@onready var TabContain = get_tree().get_first_node_in_group("TabContainer")
@onready var LabelTab = get_tree().get_first_node_in_group("LabelTab")

func _ready():
	$TabContainer/Objectives.show()
	if !PositionManager.HasOpenedTutorial:
		PositionManager.HasOpenedTutorial = true
	
	setLabels()
	setDocuments()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Closes settings Menu if "MENU" is pressed
	if Input.is_action_just_pressed("MENU") or Input.is_action_just_pressed("OBJECTIVE"):
		_on_exit_button_pressed()

# Closes settingsMenu if exit button is pressed
func _on_exit_button_pressed():
	queue_free()

func _on_document_button_pressed(extra_arg_0: int) -> void:
	TabContain.current_tab = 3
	LabelTab.text = PositionManager.DocumentsText[extra_arg_0-1]
	pass # Replace with function body.



# Sets the labels to current keybinds
func setLabels():
	%Label.text = "\n - Use '" + InputMap.action_get_events("UP")[0].as_text() + InputMap.action_get_events("LEFT")[0].as_text() + InputMap.action_get_events("DOWN")[0].as_text() + InputMap.action_get_events("RIGHT")[0].as_text() +"' to move.\n"
	%Label2.text = "\n - Press '" + InputMap.action_get_events("INTERACT")[0].as_text() + "' to interact.\n"  
	%Label5.text = "\n - Hold '" + InputMap.action_get_events("SHIFT")[0].as_text() + "' to sprint.\n"
	%Label3.text = "\n - Press '" + InputMap.action_get_events("MAP")[0].as_text() + "' to open the map.\n"
	%Label6.text = "\n - Press '" + InputMap.action_get_events("OBJECTIVE")[0].as_text() + "' to open the objectives.\n"

func setDocuments():
	var i = 0
	for x in PositionManager.Documents:
		Documents.get_child(i).text = x
		Documents.get_child(i).visible = true
		i += 1
		
	
