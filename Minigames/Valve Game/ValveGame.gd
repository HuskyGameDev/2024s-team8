extends Control

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var Valve1 = get_tree().get_first_node_in_group("Valve1")
@onready var Valve2 = get_tree().get_first_node_in_group("Valve2")
@onready var Valve3 = get_tree().get_first_node_in_group("Valve3")
@onready var Arrow1 = get_tree().get_first_node_in_group("Arrow1")
@onready var Arrow2 = get_tree().get_first_node_in_group("Arrow2")
@onready var Arrow3 = get_tree().get_first_node_in_group("Arrow3")
@onready var Steam1 = get_tree().get_first_node_in_group("Steam1")
@onready var Steam2 = get_tree().get_first_node_in_group("Steam2")
@onready var Steam3 = get_tree().get_first_node_in_group("Steam3")

@onready var ValveArray = [Valve1, Valve2, Valve3]
@onready var ArrowArray = [Arrow1, Arrow2, Arrow3]
@onready var index = 0

var Valve1Solution = PositionManager.valveCode[0] * 15
var Valve2Solution = PositionManager.valveCode[1] * 15
var Valve3Solution = PositionManager.valveCode[2] * 15

signal completed()

func ConvertDegrees(degrees):
	var newDegrees = int(degrees) % 360
	if newDegrees < 0:
		newDegrees = 360 + newDegrees
	return newDegrees

func _process(_delta):
	RotateValve()
	var Valve1Rotation = ConvertDegrees(ValveArray[0].rotation_degrees)
	var Valve2Rotation = ConvertDegrees(ValveArray[1].rotation_degrees)
	var Valve3Rotation = ConvertDegrees(ValveArray[2].rotation_degrees)
	var Valve1Steam = (abs(Valve1Solution / 15 - float(Valve1Rotation) / 15))
	var Valve2Steam = (abs(Valve2Solution / 15 - float(Valve2Rotation) / 15))
	var Valve3Steam = (abs(Valve3Solution / 15 - float(Valve3Rotation) / 15))
	Steam1.explosiveness = 1 - (float(Valve1Steam) / float(16))
	Steam2.explosiveness = 1 - (float(Valve2Steam) / float(16))
	Steam3.explosiveness = 1 - (float(Valve3Steam) / float(16))
	
	Steam1.explosiveness = 1 - (float(Valve1Steam) / float(16))
	Steam2.explosiveness = 1 - (float(Valve2Steam) / float(16))
	Steam3.explosiveness = 1 - (float(Valve3Steam) / float(16))
	
	if Valve1Steam > 1 :
		Steam1.emitting = true
	else:
		Steam1.emitting = false
		
	if Valve2Steam > 1:
		Steam2.emitting = true
	else:
		Steam2.emitting = false
		
	if Valve3Steam > 1:
		Steam3.emitting = true
	else:
		Steam3.emitting = false
	
	if Valve1Rotation > Valve1Solution - 16 && Valve1Rotation < Valve1Solution + 16:
		if Valve2Rotation >  Valve2Solution - 16 && Valve2Rotation <  Valve2Solution + 16:
			if Valve3Rotation >  Valve3Solution - 16 && Valve3Rotation <  Valve3Solution + 16:
				PositionManager.HasClearedValve = true
				await get_tree().create_timer(2).timeout
				completed.emit()
				queue_free()
				player._swap_attention()
				
	if Input.is_action_just_pressed("MENU"):
		queue_free()
		player._swap_attention()
		

func RotateValve():
	if !PositionManager.HasClearedValve:
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
			
		else:
			if Input.is_action_just_pressed("LEFT"):
				ArrowArray[index].visible = false
				if index == 0:
					index = 3
				index -= 1
				ArrowArray[index].visible = true
				
	
