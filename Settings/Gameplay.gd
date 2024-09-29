extends VBoxContainer


var defaultTextSpd = 1

@onready var textSpdSlider = %TextSpdSlider

# Sets the sliders to their respective positions if they have been altered before
func _ready():
	get_node("%TextSpdSlider").set_value_no_signal(PositionManager.textSpd)

func _on_text_spd_slider_value_changed(value):
	PositionManager.textSpd = value;


func _on_reset_gameplay_pressed() -> void:
	ConfigManager.save_gameplay("text_speed", defaultTextSpd)
	PositionManager.textSpd = defaultTextSpd
	textSpdSlider.value = defaultTextSpd
