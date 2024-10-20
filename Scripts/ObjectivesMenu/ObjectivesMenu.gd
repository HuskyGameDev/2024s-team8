extends Control

@onready var Objectives = get_tree().get_first_node_in_group("Objectives")
@onready var Documents = get_tree().get_first_node_in_group("Documents")
@onready var TabContain = get_tree().get_first_node_in_group("TabContainer")
@onready var LabelTab = get_tree().get_first_node_in_group("LabelTab")

func _ready():
	$TabContainer/Objectives.show()
	if !PositionManager.HasOpenedTutorial:
		PositionManager.HasOpenedTutorial = true
	
	setObjectives()
	setDocuments()
	setControls()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Closes settings Menu if "MENU" is pressed
	if Input.is_action_just_pressed("MENU") or Input.is_action_just_pressed("OBJECTIVE"):
		_on_exit_button_pressed()

# Closes settingsMenu if exit button is pressed
func _on_exit_button_pressed():
	queue_free()

func _on_document_button_pressed(extra_arg_0: int) -> void:
	TabContain.current_tab = 4
	LabelTab.text = PositionManager.DocumentsText[extra_arg_0-1]


# Sets the labels to current keybinds
func setControls():
	%Label.text = "\n - Use '" + InputMap.action_get_events("UP")[0].as_text() + InputMap.action_get_events("LEFT")[0].as_text() + InputMap.action_get_events("DOWN")[0].as_text() + InputMap.action_get_events("RIGHT")[0].as_text() +"' to move."
	%Label2.text = " - Press '" + InputMap.action_get_events("INTERACT")[0].as_text() + "' to interact."  
	%Label3.text = " - Hold '" + InputMap.action_get_events("SHIFT")[0].as_text() + "' to sprint."
	%Label4.text = " - Press '" + InputMap.action_get_events("MAP")[0].as_text() + "' to open the map."
	%Label5.text = " - Press '" + InputMap.action_get_events("OBJECTIVE")[0].as_text() + "' to open the objectives."
	%Label6.text = " - Use '" + InputMap.action_get_events("MENU")[0].as_text() + "' to exit dialogues,\n   cutscenes, and menus."


#Set Objectives Text
func setObjectives():
	var i = 0
	for x in PositionManager.ObjectivesText:
		if i == 0:
			Objectives.get_child(i).text = "\n - " + x
		else: 
			Objectives.get_child(i).text = " - " + x
		Objectives.get_child(i).visible = true
		i += 1

#Set Document Buttons
func setDocuments():
	var i = 0
	for x in PositionManager.Documents:
		Documents.get_child(i).text = x
		Documents.get_child(i).visible = true
		i += 1
		
	
