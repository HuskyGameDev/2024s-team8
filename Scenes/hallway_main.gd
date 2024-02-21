extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mess_hall_body_entered(body):
	const MESS = preload("res://Scenes/Main floor rooms/mess_hall.tscn")
	if body.name == "Player":
		StageManager.changeScene(MESS, 232, 120)
		StageManager.changeCamera(304)


func _on_research_room_body_entered(body):
	const RESEARCH = preload("res://Scenes/Main floor rooms/research1.tscn")
	if body.name == "Player":
		StageManager.changeScene(RESEARCH, 80, 128)
		StageManager.changeCamera(304)


func _on_pod_body_entered(body):
	const POD = preload("res://Scenes/Main floor rooms/pod.tscn")
	if body.name == "Player":
		pass#StageManager.changeScene(POD, 232, 120) StageManager.changeCamera(310) code for when scene exists 


func _on_bunks_body_entered(body):
	const BUNKS = preload("res://Scenes/Main floor rooms/bunks.tscn")
	if body.name == "Player":
		StageManager.changeScene(BUNKS, 240, 144)
		StageManager.changeCamera(304)


func _on_supply_closet_body_entered(body):
	const SUPPLY = preload("res://Scenes/Main floor rooms/supply_closet.tscn")
	if body.name == "Player":
		StageManager.changeScene(SUPPLY, 124, 116)
		StageManager.changeCamera(304)


func _on_stairs_body_entered(body):
	const STAIRS = preload("res://Scenes/Main floor rooms/supply_closet.tscn")
	if body.name == "Player":
		if 0 == 1:
			StageManager.changeScene(STAIRS, 59, 89)
			StageManager.changeCamera(304)
		else:
			get_node("Player").get_node("Control").get_node("Door_is_locked").show()


func _on_stairs_body_exited(body):
	if body.name == "Player":
		get_node("Player").get_node("Control").get_node("Door_is_locked").hide()


func _on_bridge_body_entered(body):
	pass # Replace with function body.
