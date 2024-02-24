extends Control

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var Valve1 = get_tree().get_first_node_in_group("Valve1")
@onready var Valve2 = get_tree().get_first_node_in_group("Valve2")
@onready var Valve3 = get_tree().get_first_node_in_group("Valve3")
@onready var Arrow1 = get_tree().get_first_node_in_group("Arrow1")
@onready var Arrow2 = get_tree().get_first_node_in_group("Arrow2")
@onready var Arrow3 = get_tree().get_first_node_in_group("Arrow3")

@onready var ValveArray = [Valve1, Valve2, Valve3]
@onready var ArrowArray = [Arrow1, Arrow2, Arrow3]
@onready var index = 0

func _process(_delta):
	RotateValve()
	if Input.is_action_just_pressed("MENU"):
		queue_free()
		player._swap_attention()
		

func RotateValve():
	if !player.hasAttention && player.ValveMinigame:
		if Input.is_action_pressed("DOWN"):
			ValveArray[index].rotation_degrees += 1
		else:
			if Input.is_action_pressed("UP"):
				ValveArray[index].rotation_degrees -= 1
		
		if Input.is_action_just_pressed("RIGHT"):
			ArrowArray[index].visible = false
			if index == 2:
				index = -1
			index += 1
			ArrowArray[index].visible = true
			pass
		else:
			if Input.is_action_just_pressed("LEFT"):
				ArrowArray[index].visible = false
				if index == 0:
					index = 3
				index -= 1
				ArrowArray[index].visible = true
				pass
	pass



