extends Control

func _ready():
	if StageManager.scene_change == true:
		hideAll()

func _process(_delta):
	if Input.is_action_just_pressed("MAP") or Input.is_action_just_pressed("MENU"):
		queue_free()
	var currentScene = get_tree().current_scene.name
	#print(currentScene)
	sceneChecker(currentScene)
	#print(PositionManager.PrevPosition)
	
	
func sceneChecker(node):
	if node == "hallway_main":
		get_node("Background/Rooms/Main_Hall/Outline").show()
	elif node == "Command_Deck":
		get_node("Background/Rooms/Command_Deck/Outline").show()
	elif node == "Bunks":
		get_node("Background/Rooms/Bunks/Outline").show()
	elif node == "Mess_Hall":
		get_node("Background/Rooms/Mess_Hall/Outline").show()
	elif node == "Research_1":
		get_node("Background/Rooms/Research/Outline").show()
	elif node == "stairs":
		get_node("Background/Rooms/Stairs/Outline").show()
	elif node == "Supply_Closet":
		get_node("Background/Rooms/Supply/Outline").show()
	elif node == "Airlock":
		get_node("Background/Rooms/Airlock/Outline").show()
	elif node == "Pod":
		get_node("Background/Rooms/Pod/Outline").show()

func hideAll():
	get_node("Background/Rooms/Main_Hall/Outline").hide()
	get_node("Background/Rooms/Mess_Hall/Outline").hide()
	get_node("Background/Rooms/Bunks/Outline").hide()
	get_node("Background/Rooms/Research/Outline").hide()
	get_node("Background/Rooms/Stairs/Outline").hide()
	get_node("Background/Rooms/Command_Deck/Outline").hide()
	get_node("Background/Rooms/Supply/Outline").hide()
	get_node("Background/Rooms/Pod/Outline").hide()
	get_node("Background/Rooms/Airlock/Outline").hide()
