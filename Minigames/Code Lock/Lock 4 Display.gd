extends TextureRect

@onready var number = 0
@onready var display = $Label

signal numberChange(number)

func _update_display():
	display.text = str(number)
	numberChange.emit(number)

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_display()

func _on_up_pressed():
	if number == 9:
		number = 0
	else:
		number = number+1
	_update_display()

func _on_down_pressed():
	if number == 0:
		number = 9
	else:
		number = number-1
	_update_display()
