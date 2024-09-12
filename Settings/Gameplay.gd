extends VBoxContainer

# Sets the sliders to their respective positions if they have been altered before
func _ready():
	get_node("%TextSpdSlider").set_value_no_signal(PositionManager.textSpd)

func _on_text_spd_slider_value_changed(value):
	PositionManager.textSpd = value;
