extends TextureRect


@export_multiline var text : String

@onready var label = $PanelContainer/MarginContainer/Label
@onready var panel_container = $PanelContainer


func _ready():
	label.text = text

func _process(delta):
	label.text = text

func _on_mouse_entered() -> void:
	if (label.text != ""):
		panel_container.visible = true


func _on_mouse_exited() -> void:
	panel_container.visible = false
