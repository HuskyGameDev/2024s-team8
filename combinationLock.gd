extends Control

@onready var player = get_tree().get_first_node_in_group("Player")

var locks = [0,0,0,0,0]

signal solved()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(PositionManager.comboCode)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if locks == PositionManager.comboCode:
		print("Solved")
		solved.emit()
		queue_free()
		player._swap_attention()
	if Input.is_action_just_pressed("MENU"):
		queue_free()
		player._swap_attention()

func _on_lock_1_display_number_change(number):
	locks[0] = number

func _on_lock_2_display_number_change(number):
	locks[1] = number

func _on_lock_3_display_number_change(number):
	locks[2] = number

func _on_lock_4_display_number_change(number):
	locks[3] = number

func _on_lock_5_display_number_change(number):
	locks[4] = number
