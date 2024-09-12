extends Control

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var Cursor = get_tree().get_first_node_in_group("Cursor")
@onready var Row1Node = get_tree().get_first_node_in_group("Row1")
@onready var Row2Node = get_tree().get_first_node_in_group("Row2")
@onready var Row3Node = get_tree().get_first_node_in_group("Row3")
@onready var Row4Node = get_tree().get_first_node_in_group("Row4")
@onready var Row5Node = get_tree().get_first_node_in_group("Row5")
@onready var RowNodes = [Row1Node, Row2Node, Row3Node, Row4Node, Row5Node]

@onready var Row1 = [Row1Node.get_child(0), Row1Node.get_child(1), Row1Node.get_child(2), Row1Node.get_child(3), Row1Node.get_child(4)]
@onready var Row2 = [Row2Node.get_child(0), Row2Node.get_child(1), Row2Node.get_child(2), Row2Node.get_child(3), Row2Node.get_child(4)]
@onready var Row3 = [Row3Node.get_child(0), Row3Node.get_child(1), Row3Node.get_child(2), Row3Node.get_child(3), Row3Node.get_child(4)]
@onready var Row4 = [Row4Node.get_child(0), Row4Node.get_child(1), Row4Node.get_child(2), Row4Node.get_child(3), Row4Node.get_child(4)]
@onready var Row5 = [Row5Node.get_child(0), Row5Node.get_child(1), Row5Node.get_child(2), Row5Node.get_child(3), Row5Node.get_child(4)]
@onready var Rows = [Row1, Row2, Row3, Row4, Row5]

var RowIndex0 = 0
var ColIndex0 = 0
var FlowFromDirection = 0
var solved = false
signal cleared

func _process(_delta):
	if !solved:
		if Input.is_action_just_pressed("INTERACT"):
			Rows[RowIndex0][ColIndex0].rotation_degrees += 90
			RowNodes[RowIndex0].rotatePipe(ColIndex0+1)
			if !((RowNodes[0].Pipe1[0] != true) or (RowNodes[0].Pipe1[3] != true)):
				if checkWinRecurse(1,0,3):
					if (RowNodes[4].Pipes[4][2] && RowNodes[4].Pipes[4][alternateDirection(FlowFromDirection)]):
						solved = true
						await get_tree().create_timer(2).timeout
						cleared.emit()
						queue_free()
						player._swap_attention()
		
		if Input.is_action_just_pressed("LEFT"):
			ColIndex0 = ColIndex0 - 1 if ColIndex0 > 0 else 4
		if Input.is_action_just_pressed("RIGHT"):
			ColIndex0 = ColIndex0 + 1 if ColIndex0 < 4 else 0
		if Input.is_action_just_pressed("UP"):
			RowIndex0 = RowIndex0 - 1 if RowIndex0 > 0 else 4
		if Input.is_action_just_pressed("DOWN"):
			RowIndex0 = RowIndex0 + 1 if RowIndex0 < 4 else 0
		Cursor.position = Rows[RowIndex0][ColIndex0].position
	
	if Input.is_action_just_pressed("MENU"):
		queue_free()
		player._swap_attention()


#Order, Left = 0, Up = 1, Right = 2, Down = 3
func checkWinRecurse(RowIndex, ColIndex, FromDirection):
	FlowFromDirection = FromDirection
	if RowIndex == 4 && ColIndex == 4:
		return true
	
	if !RowNodes[RowIndex].Pipes[ColIndex][alternateDirection(FromDirection)]:
		return false
	
	var directions = RowNodes[RowIndex].Pipes[ColIndex]
	for n in 4:
		if directions[n] && n != alternateDirection(FromDirection):
			if n == 0 && ColIndex > 0:
				if checkWinRecurse(RowIndex, ColIndex-1, n):
					return true
			elif n == 1 && RowIndex > 0:
				if checkWinRecurse(RowIndex-1, ColIndex, n):
					return true
			elif n == 2 && ColIndex < 4:
				if checkWinRecurse(RowIndex, ColIndex+1, n):
					return true
			elif n == 3 && RowIndex < 4:
				if checkWinRecurse(RowIndex+1, ColIndex, n):
					return true
	return false

func alternateDirection(Direction):
	if Direction == 0:
		return 2
	elif Direction == 2:
		return 0
	elif Direction == 1:
		return 3
	elif Direction == 3:
		return 1
	
	
	
	
