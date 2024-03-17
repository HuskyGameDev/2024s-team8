extends Control

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var Cursor = get_tree().get_first_node_in_group("Cursor")
@onready var Row1Node = get_tree().get_first_node_in_group("Row1")
@onready var Row2Node = get_tree().get_first_node_in_group("Row2")
@onready var Row3Node = get_tree().get_first_node_in_group("Row3")
@onready var Row4Node = get_tree().get_first_node_in_group("Row4")
@onready var Row5Node = get_tree().get_first_node_in_group("Row5")

@onready var Row1 = [Row1Node.get_child(0), Row1Node.get_child(1), Row1Node.get_child(2), Row1Node.get_child(3), Row1Node.get_child(4)]
@onready var Row2 = [Row2Node.get_child(0), Row2Node.get_child(1), Row2Node.get_child(2), Row2Node.get_child(3), Row2Node.get_child(4)]
@onready var Row3 = [Row3Node.get_child(0), Row3Node.get_child(1), Row3Node.get_child(2), Row3Node.get_child(3), Row3Node.get_child(4)]
@onready var Row4 = [Row4Node.get_child(0), Row4Node.get_child(1), Row4Node.get_child(2), Row4Node.get_child(3), Row4Node.get_child(4)]
@onready var Row5 = [Row5Node.get_child(0), Row5Node.get_child(1), Row5Node.get_child(2), Row5Node.get_child(3), Row5Node.get_child(4)]
@onready var Rows = [Row1, Row2, Row3, Row4, Row5]

var RowIndex = 0
var ColIndex = 0

func _process(_delta):
	if Input.is_action_just_pressed("INTERACT"):
		Rows[RowIndex][ColIndex].rotation_degrees += 90
	if Input.is_action_just_pressed("LEFT"):
		ColIndex = ColIndex - 1 if ColIndex > 0 else 4
	if Input.is_action_just_pressed("RIGHT"):
		ColIndex = ColIndex + 1 if ColIndex < 4 else 0
	if Input.is_action_just_pressed("UP"):
		RowIndex = RowIndex - 1 if RowIndex > 0 else 4
	if Input.is_action_just_pressed("DOWN"):
		RowIndex = RowIndex + 1 if RowIndex < 4 else 0
	Cursor.position = Rows[RowIndex][ColIndex].position
	
	if Input.is_action_just_pressed("MENU"):
		queue_free()
		player._swap_attention()
	



