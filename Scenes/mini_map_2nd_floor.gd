extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if StageManager.scene_change == true:
		hideAll()

func _process(_delta):
	if Input.is_action_just_pressed("MAP") or Input.is_action_just_pressed("MENU"):
		queue_free()
	var currentScene = get_tree().current_scene.name
	#print(currentScene)
	sceneChecker(currentScene)
	
	
func sceneChecker(node):
	if node == "PowerRoom":
		get_node("Background/Rooms/Power_Room/Outline").show()
	elif node == "Hallway_transition_2f" or node == "Hallway_Top_2f" or node == "Hallway_bottom_2f":
		get_node("Background/Rooms/Hallways/Outline").show()
	elif node == "Bathroom_With_Toilet" or node == "Bathroom_with_shower":
		get_node("Background/Rooms/Bathroom/Outline").show()
	elif node == "Security_Room":
		get_node("Background/Rooms/Security/Outline").show()
	elif node == "Boiler_Room":
		get_node("Background/Rooms/BoilerRoom/Outline").show()
	elif node == "Stairs":
		get_node("Background/Rooms/Stairs/Outline").show()
		
func hideAll():
	get_node("Background/Rooms/Power_Room/Outline").hide()
	get_node("Background/Rooms/Hallways/Outline").hide()
	get_node("Background/Rooms/Bathroom/Outline").hide()
	get_node("Background/Rooms/Security/Outline").hide()
	get_node("Background/Rooms/BoilerRoom/Outline").hide()
	get_node("Background/Rooms/Stairs/Outline").hide()
