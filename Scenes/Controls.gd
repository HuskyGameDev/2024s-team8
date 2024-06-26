extends VBoxContainer

@export var action_items: Array[String]			# Array of possible actions

@onready var control_grid_container = %CtrlGridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	create_action_remap_items()

# Creates control menu buttons and labels
func create_action_remap_items() -> void:
	var previous_item = control_grid_container.get_child(control_grid_container.get_child_count() - 1)
	
	# For each action in action_items
	for i in range(action_items.size()):
		var action = action_items[i]    
		var label = Label.new()
		
		# Sets and adds label text
		label.text = action
		label.theme_type_variation = "Label"
		control_grid_container.add_child(label)
		
		# Adds RemapButton 
		var button = RemapButton.new()
		button.action = action
		if(i != 0):
			button.focus_neighbor_top = previous_item.get_path()
			previous_item.focus_neighbor_bottom = button.get_path()
		previous_item = button
		
		control_grid_container.add_child(button)
