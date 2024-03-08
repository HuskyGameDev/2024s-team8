extends Control

var comb = [0,0,0,0,0]
var locks = [0,0,0,0,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(0,5):
		comb[n] = randi_range(0,9)
		
	print(comb)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if locks == comb:
		print("Solved")

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
