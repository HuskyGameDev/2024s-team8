extends VBoxContainer


var defaultTextSpd = 1
var defaultCRT_effect = 0

@onready var textSpdSlider = %TextSpdSlider
@onready var crtEffectSlider = %CRTEffectSlider


# Sets the sliders to their respective positions if they have been altered before
func _ready():
	get_node("%TextSpdSlider").set_value_no_signal(PositionManager.textSpd)

func _on_text_spd_slider_value_changed(value):
	PositionManager.textSpd = value;

func _on_crt_effect_slider_value_changed(value: float) -> void:
	PositionManager.crt_effect = value;

func _on_reset_gameplay_pressed() -> void:
	ConfigManager.save_gameplay("text_speed", defaultTextSpd)
	PositionManager.textSpd = defaultTextSpd
	textSpdSlider.value = defaultTextSpd
	
	ConfigManager.save_gameplay("crt_effect", defaultCRT_effect)
	PositionManager.crt_effect = defaultCRT_effect
	crtEffectSlider.value = defaultCRT_effect
	
